import 'dart:io';
import 'dart:io';
import 'package:open_file/open_file.dart' as open_file;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:star_lateks/models/barrels_model.dart';
import 'package:star_lateks/models/stock_barrel_model.dart';
import 'package:star_lateks/view/bills/screens/weight_list_summary.dart';
import 'package:star_lateks/view/common/app_alert.dart';
import 'package:star_lateks/view/customer/services/customer_provider.dart';
import 'package:intl/intl.dart';
import 'package:star_lateks/view/pdf/pdf_create_screen.dart';
import 'package:star_lateks/view/weight_list/screens/barrels_stock.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:url_launcher/url_launcher.dart';

class WeightListProvider extends ChangeNotifier {
  TextEditingController customerController = TextEditingController();
  final TextEditingController advancePaidControl = TextEditingController();
  TextEditingController enterBarrel = TextEditingController();
  List<StockBarrel>? stockBarrels;
  TextEditingController balanceBarrels = TextEditingController();
  TextEditingController placedBarrels = TextEditingController();
  TextEditingController grossWeight = TextEditingController();

  final TextEditingController weightControl = TextEditingController();
  List<CustomerModel> _customerList = [];

  CustomerModel? selectedCustomer;
  List<CustomerModel> get customerList => _customerList;
  List<Barrels> _barrelsCount = [];
  List<Barrels> get barrelsCountList => _barrelsCount;

  final CollectionReference _customerReference =
      FirebaseFirestore.instance.collection('customers');
  final TextEditingController customerNameController = TextEditingController();

  Future<void> submit(BuildContext context) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const WeightListSummarys()));
  }

  Future<void> getCustomerList() async {
    final QuerySnapshot querySnapshot = await _customerReference.get();

    _customerList = querySnapshot.docs
        .map((e) => CustomerModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();
    notifyListeners();
  }

  void sendFileToWhatsApp(String fileUrl, String mobile) async {
    String caption = 'Check out your bill from star lateks';

    String whatsappUrl =
        "whatsapp://send?text=$caption&phone=$mobile&source&data=$fileUrl";

    // Launch WhatsApp with the share URL
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch WhatsApp';
    }
  }

  Future<void> getCustomerValues(String value) async {
    List custList = [];
    selectedCustomer = null;
    for (var element in customerList) {
      if (element.name.toLowerCase().contains(value.toLowerCase())) {
        custList.add(element);
        selectedCustomer = element;
        notifyListeners();
      }
    }

    balanceBarrels.text = custList[0].barrelsRemaining.toString();
    placedBarrels.text = custList[0].barrelsTaken.toString();
    notifyListeners();
  }

  Future<void> addWeightListToFirebase() async {
    await FirebaseFirestore.instance.collection('weight_list_db').add({
      'customerName': selectedCustomer!.name,
      "id": "",
      'customer_id': selectedCustomer!.uid,
      'advancePaid': advancePaidControl.text,
      'balanceBarrels': balanceBarrels.text,
      'placedBarrels': placedBarrels.text,
      'totalWeight': grossWeight.text,
      'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    }).then((value) => {
          FirebaseFirestore.instance
              .collection('weight_list_db')
              .doc(value.id)
              .update({"id": value.id}),
          for (var element in _barrelsCount)
            {
              FirebaseFirestore.instance.collection('barrels_db').add({
                'grossWeight': element.grossWeight,
                'weight_list_id': value.id,
                'barrel_id': element.id,
                'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
              })
            }
        });
  }

  void addBarrels(BuildContext context) {
    if (grossWeight.text == '') {
      AppAlert.showWrongSnackbar(context, 'Please enter gross weight');
    } else {
      _barrelsCount.add(Barrels(
          grossWeight: grossWeight.text,
          id: (_barrelsCount.length + 1).toString()));
      notifyListeners();

      AppAlert.showSuccessSnackbar(context, 'Barrels added successfully');
      Navigator.pop(context);
      grossWeight.clear();
    }
  }

  void removeBarrels(int index) {
    _barrelsCount.removeAt(index);
    notifyListeners();
  }

  Future<void> getStockBarrels() async {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('weight_list_db').get();
    stockBarrels = querySnapshot.docs
        .map((e) => StockBarrel.fromJson(e.data() as Map<String, dynamic>))
        .toList();
    notifyListeners();
  }

  Future<void> generatePDFToBill(BuildContext context) async {
    final PdfDocument document = PdfDocument();
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    //Get page client size
    final Size pageSize = page.getClientSize();
    //Draw rectangle
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(PdfColor(142, 170, 219)));
    //Generate PDF grid.
    final PdfGrid grid = getGrid();
    //Draw the header section by creating text element
    final PdfLayoutResult result = drawHeader(page, pageSize, grid);
    //Draw grid
    drawGrid(page, grid, result);
    //Add invoice footer
    drawFooter(page, pageSize);
    //Save the PDF document
    final List<int> bytes = document.saveSync();
    //Dispose the document.
    document.dispose();
    //Save and launch the file.
    await saveAndLaunchFile(bytes, 'star_latex.pdf');

    String? path;
    if (Platform.isAndroid ||
        Platform.isIOS ||
        Platform.isLinux ||
        Platform.isWindows) {
      final Directory directory =
          await path_provider.getApplicationSupportDirectory();
      path = directory.path;
    } else {
      path = await PathProviderPlatform.instance.getApplicationSupportPath();
    }
    final File file = File(
        Platform.isWindows ? '$path\\star_latex.pdf' : '$path/star_latex.pdf');
    await file.writeAsBytes(bytes, flush: true);
    if (Platform.isAndroid || Platform.isIOS) {
      print('send file to whatsapp');
      //   await open_file.OpenFile.open('$path/star_latex.pdf');
      sendFileToWhatsApp('$path/star_latex.pdf', '+919567602385');
    } else if (Platform.isWindows) {
      await Process.run('start', <String>['$path\\star_latex.pdf'],
          runInShell: true);
    } else if (Platform.isMacOS) {
      await Process.run('open', <String>['$path/star_latex.pdf'],
          runInShell: true);
    } else if (Platform.isLinux) {
      await Process.run('xdg-open', <String>['$path/star_latex.pdf'],
          runInShell: true);
    }
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const BarrelsStockScreen()));
  }

  Future<void> generateInvoice(BuildContext context) async {
    addWeightListToFirebase();
    //Create a PDF document.
    final PdfDocument document = PdfDocument();
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    //Get page client size
    final Size pageSize = page.getClientSize();
    //Draw rectangle
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(PdfColor(142, 170, 219)));
    //Generate PDF grid.
    final PdfGrid grid = getGrid();
    //Draw the header section by creating text element
    final PdfLayoutResult result = drawHeader(page, pageSize, grid);
    //Draw grid
    drawGrid(page, grid, result);
    //Add invoice footer
    drawFooter(page, pageSize);
    //Save the PDF document
    final List<int> bytes = document.saveSync();
    //Dispose the document.
    document.dispose();
    //Save and launch the file.
    await saveAndLaunchFile(bytes, 'star_latex.pdf');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BarrelsStockScreen()));
  } //Draws the invoice header

  PdfLayoutResult drawHeader(PdfPage page, Size pageSize, PdfGrid grid) {
    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(91, 126, 215)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90));
    //Draw string
    page.graphics.drawString(
        'STAR LATEKS', PdfStandardFont(PdfFontFamily.helvetica, 30),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
        brush: PdfSolidBrush(PdfColor(65, 104, 205)));

    page.graphics.drawString(r'Rs ' + getTotalAmount(grid).toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 18),
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
        brush: PdfBrushes.white,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle));

    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
    //Draw string
    page.graphics.drawString('Advance Amount', contentFont,
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));
    //Create data foramt and convert it to text.
    final DateFormat format = DateFormat.yMMMMd('en_US');
    final String invoiceNumber =
        'Invoice Number: 2058557939\r\n\r\nDate: ${format.format(DateTime.now())}';
    final Size contentSize = contentFont.measureString(invoiceNumber);
    // ignore: leading_newlines_in_multiline_strings
    String address = '''Bill To: \r\n\r\n${selectedCustomer!.name}, 
        \r\n\r\n${selectedCustomer!.address}, 
        \r\n\r\n9920 Near Urban bank, \r\n\r\n${selectedCustomer!.phone}''';

    PdfTextElement(text: invoiceNumber, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 120,
            contentSize.width + 30, pageSize.height - 120));

    return PdfTextElement(text: address, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(30, 120,
            pageSize.width - (contentSize.width + 30), pageSize.height - 120))!;
  }

  //Draws the grid
  void drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
    Rect? totalPriceCellBounds;
    Rect? quantityCellBounds;
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    //Draw the PDF grid and get the result.
    result = grid.draw(
        page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0))!;

    //Draw grand total.
    page.graphics.drawString('Grand Total',
        PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            quantityCellBounds!.left,
            result.bounds.bottom + 10,
            quantityCellBounds!.width,
            quantityCellBounds!.height));
    page.graphics.drawString(getTotalAmount(grid).toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            totalPriceCellBounds!.left,
            result.bounds.bottom + 10,
            totalPriceCellBounds!.width,
            totalPriceCellBounds!.height));
  }

  //Draw the invoice footer data.
  void drawFooter(PdfPage page, Size pageSize) {
    final PdfPen linePen =
        PdfPen(PdfColor(142, 170, 219), dashStyle: PdfDashStyle.custom);
    linePen.dashPattern = <double>[3, 3];
    //Draw line
    page.graphics.drawLine(linePen, Offset(0, pageSize.height - 100),
        Offset(pageSize.width, pageSize.height - 100));

    const String footerContent =
        // ignore: leading_newlines_in_multiline_strings
        '''800 Interchange Blvd.\r\n\r\nSuite 2501, Austin,
         TX 78721\r\n\r\nAny Questions? support@adventure-works.com''';

    //Added 30 as a margin for the layout
    page.graphics.drawString(
        footerContent, PdfStandardFont(PdfFontFamily.helvetica, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.right),
        bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 70, 0, 0));
  }

  //Create PDF grid and return
  PdfGrid getGrid() {
    //Create a PDF grid
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: 5);
    //Create the header row of the grid.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    //Set style
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.cells[0].value = 'No.';
    headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[1].value = 'Barrel ID';
    headerRow.cells[2].value = 'Weight';
    headerRow.cells[3].value = 'Quantity';
    headerRow.cells[4].value = 'Total';
    //Add rows

    for (var element in _barrelsCount) {
      addProducts(element.id, element.id, double.parse(element.grossWeight), 2,
          17.98, grid);
    }
    // addProducts('1.', '132435654', 8.99, 2, 17.98, grid);
    // addProducts('2.', '543223333', 49.99, 3, 149.97, grid);
    // addProducts('3.', '123143242', 9.5, 2, 19, grid);
    // addProducts('4.', '234234434', 49.99, 4, 199.96, grid);
    // addProducts('5.', '324324343', 175.49, 6, 1052.94, grid);
    // addProducts('6.', '324234233', 34.99, 1, 34.99, grid);
    //Apply the table built-in style
    grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
    //Set gird columns width
    grid.columns[1].width = 200;
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        if (j == 0) {
          cell.stringFormat.alignment = PdfTextAlignment.center;
        }
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }
    return grid;
  }

  //Create and row for the grid.
  void addProducts(String productId, String productName, double price,
      int quantity, double total, PdfGrid grid) {
    final PdfGridRow row = grid.rows.add();
    row.cells[0].value = productId;
    row.cells[1].value = productName;
    row.cells[2].value = price.toString();
    row.cells[3].value = quantity.toString();
    row.cells[4].value = total.toString();
  }

  //Get the total amount.
  double getTotalAmount(PdfGrid grid) {
    double total = 0;
    for (int i = 0; i < grid.rows.count; i++) {
      final String value =
          grid.rows[i].cells[grid.columns.count - 1].value as String;
      total += double.parse(value);
    }
    return advancePaidControl.text == ''
        ? 0
        : double.parse(advancePaidControl.text);
  }
}
