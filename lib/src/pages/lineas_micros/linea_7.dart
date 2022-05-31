import 'package:google_maps_flutter/google_maps_flutter.dart';

class Linea7Ida {
  static const List IN = [
    [-65.23282527923583, -19.05165253577314],
    [-65.2333402633667, -19.052098746245363],
    [-65.23452043533325, -19.05256523772865],
    [-65.23645162582396, -19.052970881430515],
    [-65.23784637451172, -19.051916205742682],
    [-65.23902654647827, -19.050861523350342],
    [-65.23936986923218, -19.0508006760847],
    [-65.24020671844482, -19.051145476961636],
    [-65.24091482162476, -19.050942653003162],
    [-65.2411937713623, -19.05053700434237],
    [-65.2414083480835, -19.05033417964008],
    [-65.24295330047607, -19.05002994212177],
    [-65.24466991424559, -19.049806834253825],
    [-65.24509906768799, -19.049543160932185],
    [-65.24542093276978, -19.049238921963518],
    [-65.24587154388428, -19.048812986470264],
    [-65.2461290359497, -19.04850874616285],
    [-65.24627923965454, -19.048650725042393],
    [-65.24664402008055, -19.04921863934579],
    [-65.24703025817871, -19.049766269154684],
    [-65.24756669998169, -19.050618134153876],
    [-65.24773836135864, -19.05076011122854],
    [-65.24793148040771, -19.050820958509068],
    [-65.24806022644043, -19.051003500216744],
    [-65.24795293807982, -19.051267171217738],
    [-65.24808168411255, -19.05159168879758],
    [-65.24878978729248, -19.052402979970186],
    [-65.24996995925903, -19.053356242028595],
    [-65.2503776550293, -19.053761883796362],
    [-65.25076389312744, -19.053822729975984],
    [-65.25123596191405, -19.053721319664234],
    [-65.25168657302856, -19.05337652414054],
    [-65.252845287323, -19.05258551993729],
    [-65.25494813919067, -19.050902088181708],
    [-65.25685787200928, -19.049320052409723],
    [-65.25870323181152, -19.04781913273433],
    [-65.257887840271, -19.046906404672445],
    [-65.25709390640259, -19.04595310555952],
    [-65.25872468948364, -19.0442696065189],
    [-65.26082754135132, -19.042900483263377],
    [-65.26296257972717, -19.041257520450593],
    [-65.26301622390747, -19.041186527863804],
    [-65.26238322257996, -19.04045631663761],
    [-65.26197552680969, -19.040030358605787],
    [-65.26097774505615, -19.0388437554688],
    [-65.25944352149963, -19.037058763836473],
    [-65.25811314582825, -19.035446169670845],
    [-65.25780200958252, -19.0354765961208],
    [-65.25758743286133, -19.035456311821463],
    [-65.25737285614014, -19.035263610854035],
    [-65.25709390640259, -19.034665222214144],
    [-65.25683641433714, -19.034107400353815],
    [-65.25678277015686, -19.033407584824783],
    [-65.2564287185669, -19.033519149816843],
    [-65.25658965110779, -19.03459422680871],
    [-65.25636434555054, -19.03455365799197],
    [-65.25582790374756, -19.033792990843256],
    [-65.25511980056763, -19.0328091894975],
    [-65.25459408760071, -19.032403496523884],
    [-65.2540361881256, -19.032068799074665],
    [-65.25370359420776, -19.032018087281113],
    [-65.25270581245422, -19.031967375472068],
    [-65.25199770927429, -19.033143885454727],
    [-65.2521800994873, -19.033164170036528],
    [-65.25330662727356, -19.03315402774594],
    [-65.2541434764862, -19.03315402774594],
    [-65.25499105453491, -19.03202822964105],
    [-65.25543093681335, -19.03135883255581],
    [-65.25545239448547, -19.03119655406827],
    [-65.25580644607544, -19.030993705735906],
    [-65.25591373443604, -19.031054560261623],
    [-65.2561604976654, -19.03104441784222],
    [-65.25668621063232, -19.03104441784222],
    [-65.25660037994385, -19.02918834466495],
    [-65.25709390640259, -19.028823213074215],
    [-65.2577269077301, -19.028711644928087],
    [-65.2586817741394, -19.02887392584314],
    [-65.25949716567993, -19.029097061842506],
    [-65.26002287864685, -19.029168059597634],
    [-65.26112794876099, -19.02939119520191],
    [-65.26265144348145, -19.02966504303391],
    [-65.26288747787476, -19.029634615519303],
    [-65.263112783432, -19.029289769964375],
    [-65.2635633945465, -19.02896520878819],
    [-65.26399254798889, -19.02856964899736],
    [-65.26453971862793, -19.027971236241594],
    [-65.26496887207031, -19.0276973856175],
    [-65.26548385620117, -19.027535103553184],
    [-65.2659559249878, -19.026967115079774],
    [-65.26700735092163, -19.02503999686076],
    [-65.26728630065918, -19.024674856153233],
    [-65.26790857315063, -19.024532856772495],
    [-65.26880979537964, -19.02459371366481],
    [-65.26968955993652, -19.024350285961813],
    [-65.27026891708374, -19.023944572331043],
    [-65.2708911895752, -19.022098562804278],
    [-65.27125597000122, -19.02179427355104],
    [-65.27183532714844, -19.02159141373936],
    [-65.27252197265625, -19.021733415633534],
    [-65.27318716049194, -19.022017419057885],
    [-65.27451753616333, -19.022301421996914],
    [-65.27544021606445, -19.02262599619009],
    [-65.27677059173584, -19.02327514267467],
    [-65.27698516845703, -19.0235591434643],
    [-65.2773928642273, -19.024796569811556],
    [-65.27780055999756, -19.025364565704958],
    [-65.27812242507935, -19.025567420910626],
    [-65.27837991714478, -19.025851417782505],
    [-65.27951717376708, -19.026601978607218],
    [-65.28162002563477, -19.027251109559202],
    [-65.28269290924072, -19.024857426607298],
    [-65.28301477432251, -19.02376200087402],
    [-65.28488159179688, -19.021347981638478],
    [-65.28664112091064, -19.018954213655554],
    [-65.29097557067871, -19.01453173806558],
    [-65.29187679290771, -19.0152417764781],
    [-65.29361486434937, -19.01686471003393],
    [-65.29449462890625, -19.017635597922702],
    [-65.29428005218506, -19.01814275905784],
    [-65.29365777969359, -19.018507914117013],
    [-65.29294967651367, -19.018751350377485],
    [-65.29262781143188, -19.018913641019743],
    [-65.29243469238281, -19.01925850810841],
    [-65.29224157333374, -19.0198873815457],
    [-65.29211282730103, -19.02023224661403],
    [-65.29226303100586, -19.02049596647758],
    [-65.29282093048096, -19.02071911372761],
    [-65.29425859451294, -19.021347981638478],
    [-65.29625415802002, -19.022078276871405],
    [-65.29676914215088, -19.022727425495464],
    [-65.29618978500366, -19.02481685541261],
    [-65.29601812362671, -19.025323994634107],
    [-65.29554605484009, -19.025729704896865],
    [-65.29571771621704, -19.025851417782505],
    [-65.29646873474121, -19.02593255965676],
    [-65.29865741729736, -19.026175985041704],
    [-65.29985904693604, -19.026317983018238],
    [-65.30041694641113, -19.026439695472952],
    [-65.30099630355835, -19.0265208370599],
    [-65.30080318450928, -19.028285656771843],
    [-65.30097484588623, -19.028975351334545],
    [-65.30045986175537, -19.02952304791812]
  ];

  static LatLng SOURCE_LOCATION =
      LatLng(-19.02952304791812, -65.30044913291931);
  static LatLng DEST_LOCATION = LatLng(-19.05165253577314, -65.23281991481781);
}
