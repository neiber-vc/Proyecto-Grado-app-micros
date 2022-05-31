import 'package:google_maps_flutter/google_maps_flutter.dart';

class Linea6Ida {
  static const List IN = [
    [-65.25381088256836, -19.00684284222002],
    [-65.25260925292969, -19.008993334386652],
    [-65.25142908096313, -19.009987420424522],
    [-65.2511715888977, -19.01116408601437],
    [-65.25181531906128, -19.01173212849168],
    [-65.25215864181519, -19.012421891748303],
    [-65.25215864181519, -19.01357825314162],
    [-65.25293111801147, -19.014105713562543],
    [-65.2531886100769, -19.014430303759102],
    [-65.25325298309326, -19.015302636772375],
    [-65.25288820266722, -19.01660098440921],
    [-65.25245904922485, -19.01745301953529],
    [-65.25205135345459, -19.01814275905784],
    [-65.2518367767334, -19.01905564520173],
    [-65.25149345397949, -19.019603374481555],
    [-65.25119304656982, -19.019745378074287],
    [-65.25042057037354, -19.0201105296128],
    [-65.25020599365234, -19.020800258107887],
    [-65.24990558624268, -19.021246551491227],
    [-65.24896144866943, -19.02067854152261],
    [-65.24863958358765, -19.02098283281864],
    [-65.24855375289917, -19.021185693373162],
    [-65.24795293807982, -19.022808568895176],
    [-65.24705171585083, -19.02465457053484],
    [-65.24632215499877, -19.026419410070023],
    [-65.24782419204712, -19.02668312011492],
    [-65.2483606338501, -19.02664254936603],
    [-65.24855375289917, -19.026561407838507],
    [-65.24851083755493, -19.027129397698893],
    [-65.2489399909973, -19.02723082425535],
    [-65.24934768676758, -19.027393106616884],
    [-65.2494764328003, -19.027616244605163],
    [-65.25014162063599, -19.02794080841676],
    [-65.25044202804565, -19.02887392584314],
    [-65.25076389312744, -19.029888177970637],
    [-65.25181531906128, -19.029563617963582],
    [-65.25258779525757, -19.02936076763715],
    [-65.25331735610962, -19.029178202131597],
    [-65.25456190109253, -19.028914496047136],
    [-65.25473356246948, -19.029746183045578],
    [-65.25492668151855, -19.030699575213976],
    [-65.25518417358397, -19.031226981296765],
    [-65.25511980056763, -19.031368974956013],
    [-65.25415420532227, -19.031876094176745],
    [-65.25411128997803, -19.032078941431525],
    [-65.25456190109253, -19.032403496523884],
    [-65.25507688522339, -19.03195723310839],
    [-65.25537729263306, -19.03145011413537],
    [-65.25548458099365, -19.031247266112665],
    [-65.25580644607544, -19.03100384815841],
    [-65.25610685348511, -19.031084987516135],
    [-65.25610685348511, -19.0300098878098],
    [-65.25640726089478, -19.02934048259089],
    [-65.25670766830444, -19.029097061842506],
    [-65.25726556777954, -19.028833355629235],
    [-65.25784492492676, -19.028691359802554],
    [-65.2587890625, -19.02893478114542],
    [-65.25999069213867, -19.02919848719768],
    [-65.26067733764648, -19.02934048259089],
    [-65.26258707046509, -19.02966504303391],
    [-65.26286602020264, -19.029644758024794],
    [-65.26303768157959, -19.02936076763715],
    [-65.26323080062866, -19.029299912490934],
    [-65.26335954666138, -19.029482477862743],
    [-65.26318788528442, -19.029949032901364],
    [-65.26308059692381, -19.030293877087722],
    [-65.26308059692381, -19.03106470268041],
    [-65.26312351226807, -19.031896378913373],
    [-65.26318788528442, -19.032139795559644],
    [-65.26333808898926, -19.032342642492374],
    [-65.26400327682495, -19.032586058484632],
    [-65.26445388793945, -19.032910612586058],
    [-65.26453971862793, -19.033296019757774],
    [-65.26460409164429, -19.033863986591225],
    [-65.26445388793945, -19.034087115887214],
    [-65.26413202285767, -19.034391382625927],
    [-65.26312351226807, -19.03516218920241],
    [-65.26280164718628, -19.03637924493366],
    [-65.26346683502197, -19.0362981081624],
    [-65.26385307312012, -19.036784928195207],
    [-65.26408910751343, -19.03706890588858],
    [-65.26490449905396, -19.036906632980422],
    [-65.26578426361084, -19.036784928195207],
    [-65.26623487472534, -19.036642939166416],
    [-65.26672840118408, -19.036642939166416],
    [-65.26728630065918, -19.036703791622188],
    [-65.26793003082275, -19.03684578059896],
    [-65.26844501495361, -19.03765714385136],
    [-65.2684235572815, -19.038285947645033],
    [-65.2682089805603, -19.038671342341544],
    [-65.26760816574097, -19.038935032934262],
    [-65.26666402816772, -19.039117587714657],
    [-65.2662992477417, -19.039016168417],
    [-65.26587009429932, -19.03913787156676],
    [-65.2651834487915, -19.039726102199655],
    [-65.26329517364502, -19.041186527863804],
    [-65.26207208633423, -19.042139854352975],
    [-65.26235103607178, -19.042342689069866],
    [-65.26286602020264, -19.042991758498406],
    [-65.26168584823608, -19.044005924399578],
    [-65.26076316833496, -19.04469555367293],
    [-65.25891780853271, -19.046135652622045],
    [-65.25775909423828, -19.04717008218372],
    [-65.25679349899292, -19.04781913273433],
    [-65.25602102279663, -19.04842761532002],
    [-65.25413274765015, -19.049989377077193],
    [-65.25336027145386, -19.04907666095216],
    [-65.25267362594604, -19.049685138926666],
    [-65.25198698043823, -19.050374744600383],
    [-65.25198698043823, -19.049766269154684],
    [-65.25200843811035, -19.04917807410286],
    [-65.2517294883728, -19.04836676716185],
    [-65.25033473968506, -19.047656870334645],
    [-65.24930477142334, -19.04714979931312],
    [-65.24842500686646, -19.04664272674223],
    [-65.24775981903076, -19.046216784585383],
    [-65.24733066558838, -19.046825273046245],
    [-65.246901512146, -19.046987536259007],
    [-65.2461290359497, -19.047109233564456],
    [-65.24482011795044, -19.04739319359682],
    [-65.24469137191772, -19.047656870334645],
    [-65.24432659149169, -19.047575739075327],
    [-65.24372577667236, -19.047514890604802],
    [-65.24316787719727, -19.047697435949445],
    [-65.24250268936157, -19.04735262790765],
    [-65.24149417877197, -19.04714979931312],
    [-65.24115085601807, -19.04694697047069],
    [-65.24089336395264, -19.04700781914945],
    [-65.24039983749388, -19.047535173430784],
    [-65.24076461791992, -19.047879981093295],
    [-65.24106502532959, -19.048143657057683],
    [-65.24007797241211, -19.049096943587255],
    [-65.23964881896973, -19.0488332691376]
  ];

  static LatLng SOURCE_LOCATION =
      LatLng(-19.006852986116254, -65.25382161140442);
  static LatLng DEST_LOCATION = LatLng(-19.0488332691376, -65.2396434545517);
}
