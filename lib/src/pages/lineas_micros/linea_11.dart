import 'package:google_maps_flutter/google_maps_flutter.dart';

class Linea11Ida {
  static const List IN = [
    [-65.2778971195221, -19.05547570931688],
    [-65.27807950973511, -19.05546556838954],
    [-65.27799367904663, -19.054897675469306],
    [-65.27772545814513, -19.054157383564956],
    [-65.27794003486633, -19.05348807571192],
    [-65.27800440788269, -19.05261594324562],
    [-65.27777910232544, -19.05199733487977],
    [-65.27740359306335, -19.051480135951103],
    [-65.27675986289978, -19.05048629819005],
    [-65.27673840522765, -19.04991838822529],
    [-65.27710318565369, -19.049482313183084],
    [-65.277339220047, -19.04914765016415],
    [-65.27743577957153, -19.0488332691376],
    [-65.27746796607971, -19.04874199711511],
    [-65.27719974517822, -19.048569594268958],
    [-65.27670621871948, -19.048305918981367],
    [-65.27641654014587, -19.047808991338993],
    [-65.27607321739195, -19.047575739075327],
    [-65.27579426765442, -19.04743375927606],
    [-65.27550458908081, -19.04743375927606],
    [-65.27505397796631, -19.047748142953985],
    [-65.27480721473694, -19.048021960510795],
    [-65.27379870414734, -19.048174081180456],
    [-65.27355194091797, -19.048295777615785],
    [-65.27333736419678, -19.048600018313657],
    [-65.27329444885254, -19.048721714436617],
    [-65.27292966842651, -19.048721714436617],
    [-65.27257561683655, -19.0485594529195],
    [-65.27238249778748, -19.048468180746404],
    [-65.27200698852539, -19.048650725042393],
    [-65.27177095413208, -19.048731855776154],
    [-65.27156710624695, -19.048681149072202],
    [-65.27140617370605, -19.048589876966037],
    [-65.27109503746033, -19.048539170218692],
    [-65.27079463005066, -19.048589876966037],
    [-65.27045130729675, -19.048468180746404],
    [-65.27029037475586, -19.048346484437495],
    [-65.26989340782166, -19.048336343074393],
    [-65.26956081390381, -19.04848846345586],
    [-65.26893854141235, -19.04850874616285],
    [-65.26840209960938, -19.048346484437495],
    [-65.26832699775696, -19.04857973561781],
    [-65.26829481124878, -19.048762279791106],
    [-65.2677047252655, -19.04890425845372],
    [-65.26759743690491, -19.04884341047033],
    [-65.26739358901978, -19.04844789803445],
    [-65.26726484298706, -19.04839719124372],
    [-65.2661383152008, -19.048498604809673],
    [-65.26602029800415, -19.048468180746404],
    [-65.26582717895508, -19.048681149072202],
    [-65.26548385620117, -19.048234929409272],
    [-65.26480793952942, -19.047413476437676],
    [-65.2640676498413, -19.046541312042145],
    [-65.26320934295654, -19.045598152363144],
    [-65.26247978210449, -19.04478682792088],
    [-65.26243686676025, -19.044614420965964],
    [-65.26254415512085, -19.044289889741496],
    [-65.26262998580933, -19.044117482270412],
    [-65.26273727416992, -19.04399578277123],
    [-65.26273727416992, -19.043924791355508],
    [-65.26325225830078, -19.04345827558254],
    [-65.26289820671082, -19.043012041877155],
    [-65.26205062866211, -19.0419268776335],
    [-65.26187896728516, -19.041551632272466],
    [-65.26149272918701, -19.04103440078988],
    [-65.26105284690857, -19.041267662246238],
    [-65.26053786277771, -19.041835601812945],
    [-65.26023745536804, -19.04221084653208],
    [-65.25999069213867, -19.042342689069866],
    [-65.25977611541748, -19.04261651554453],
    [-65.2594757080078, -19.04275849946468],
    [-65.25933623313904, -19.042849774777782],
    [-65.25931477546692, -19.042981616808103],
    [-65.25898218154907, -19.043022183565586],
    [-65.25859594345093, -19.042880199870993],
    [-65.25854229927063, -19.042768641168617],
    [-65.25827407836914, -19.04255566525586],
    [-65.25801658630371, -19.041815318290446],
    [-65.25800585746765, -19.041632766476454],
    [-65.25775909423828, -19.04057801873168],
    [-65.25768399238586, -19.039371135687787],
    [-65.25753378868103, -19.03855978081087],
    [-65.25735139846802, -19.03814395989977],
    [-65.25701880455017, -19.037565865683376],
    [-65.2568793296814, -19.037180468420967],
    [-65.25704026222229, -19.036947201222322],
    [-65.25809168815613, -19.036450239575977],
    [-65.25805950164795, -19.036287966063217],
    [-65.25776982307434, -19.0355983018649],
    [-65.25760889053345, -19.035486738269565],
    [-65.25749087333679, -19.03538531675421],
    [-65.25721192359924, -19.03486806606246],
    [-65.2568256855011, -19.03406683141816],
    [-65.25681495666504, -19.03352929208513],
    [-65.25676131248474, -19.033174312326494],
    [-65.25633215904234, -19.03335687343998],
    [-65.25655746459961, -19.03451308916532],
    [-65.25654673576355, -19.034665222214144],
    [-65.25629997253418, -19.03451308916532],
    [-65.25590300559998, -19.033884271085064],
    [-65.25550603866576, -19.03338730027273],
    [-65.2552056312561, -19.033985693517117],
    [-65.25470137596129, -19.034776786361373],
    [-65.25364995002747, -19.036531376272887],
    [-65.2527379989624, -19.03800197203309],
    [-65.25222301483153, -19.038894465178018],
    [-65.251944065094, -19.03920886502959],
    [-65.25168657302856, -19.039695676528382],
    [-65.25166511535645, -19.039807237295804],
    [-65.25079607963562, -19.039350851864178],
    [-65.24996995925903, -19.038701768200546],
    [-65.24925112724304, -19.039584115685965],
    [-65.24876832962036, -19.039462412863323],
    [-65.24799585342407, -19.039269716544997],
    [-65.2474057674408, -19.039168297340265],
    [-65.24649381637573, -19.038995884550022],
    [-65.2456784248352, -19.03886403935435],
    [-65.24498105049133, -19.038468503139104],
    [-65.24480938911438, -19.03840765133004],
    [-65.24473428726196, -19.038164243870813],
    [-65.24436950683594, -19.037403593260873],
    [-65.24396181106567, -19.036450239575977],
    [-65.24379014968872, -19.03566929684108],
    [-65.24423003196716, -19.034614511213352],
    [-65.24458944797514, -19.033732137320854],
    [-65.24490594863892, -19.032626627781994],
    [-65.24514198303223, -19.031399402152932],
    [-65.24546384811401, -19.029350625114333],
    [-65.24541020393372, -19.02918834466495],
    [-65.24533510208128, -19.029127489455554],
    [-65.24492740631104, -19.029107204380807],
    [-65.243843793869, -19.028975351334545],
    [-65.24339318275452, -19.028823213074215],
    [-65.24320006370544, -19.028650789544066],
    [-65.24298548698425, -19.028498650986496],
    [-65.24266362190247, -19.028447938103017],
    [-65.24226665496826, -19.02845808068095],
    [-65.2421486377716, -19.028498650986496],
    [-65.24111866950989, -19.02857979156788],
    [-65.24088263511656, -19.02846822325827],
    [-65.2407431602478, -19.028021949270588],
    [-65.24077534675598, -19.027464105100194],
    [-65.23965954780579, -19.027251109559202],
    [-65.23926258087158, -19.026865688362342],
    [-65.23891925811768, -19.024309714643312],
    [-65.23868322372437, -19.02400542943881],
    [-65.23865640163422, -19.023883715200984],
    [-65.23849546909332, -19.023584500654064],
    [-65.2384203672409, -19.02296578411938],
    [-65.23835599422455, -19.022940426835206]
  ];

  static LatLng SOURCE_LOCATION =
      LatLng(-19.05547570931688, -65.27789779007435);
  static LatLng DEST_LOCATION = LatLng(-19.022940426835206, -65.23835599422455);
}
