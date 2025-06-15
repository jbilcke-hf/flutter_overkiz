import 'models/overkiz_server.dart';
import 'enums/server.dart';

const String cozytouchAtlanticApi = 'https://apis.groupe-atlantic.com';
const String cozytouchClientId = 'Q3RfMUpWeVRtSUxYOEllZkE3YVVOQmpGblpVYToyRWNORHpfZHkzNDJVSnFvMlo3cFNKTnZVdjBh';

const String nexityApi = 'https://api.egn.prd.aws-nexity.fr';
const String nexityCognitoClientId = '3mca95jd5ase5lfde65rerovok';
const String nexityCognitoUserPool = 'eu-west-1_wj277ucoI';
const String nexityCognitoRegion = 'eu-west-1';

const String somfyApi = 'https://accounts.somfy.com';
const String somfyClientId = '0d8e920c-1478-11e7-a377-02dd59bd3041_1ewvaqmclfogo4kcsoo0c8k4kso884owg08sg8c40sk4go4ksg';
const String somfyClientSecret = '12k73w1n540g8o4cokg0cw84cog840k84cwggscwg884004kgk';

const String localApiPath = '/enduser-mobile-web/1/enduserAPI/';

const List<Server> serversWithLocalApi = [
  Server.somfyEurope,
  Server.somfyOceania,
  Server.somfyAmerica,
];

const Map<Server, OverkizServer> supportedServers = {
  Server.atlanticCozytouch: OverkizServer(
    name: 'Atlantic Cozytouch',
    endpoint: 'https://ha110-1.overkiz.com/enduser-mobile-web/enduserAPI/',
    manufacturer: 'Atlantic',
    configurationUrl: null,
  ),
  Server.brandt: OverkizServer(
    name: 'Brandt Smart Control',
    endpoint: 'https://ha3-1.overkiz.com/enduser-mobile-web/enduserAPI/',
    manufacturer: 'Brandt',
    configurationUrl: null,
  ),
  Server.flexom: OverkizServer(
    name: 'Flexom',
    endpoint: 'https://ha108-1.overkiz.com/enduser-mobile-web/enduserAPI/',
    manufacturer: 'Bouygues',
    configurationUrl: null,
  ),
  Server.hexaomHexaconnect: OverkizServer(
    name: 'Hexaom HexaConnect',
    endpoint: 'https://ha5-1.overkiz.com/enduser-mobile-web/enduserAPI/',
    manufacturer: 'Hexaom',
    configurationUrl: null,
  ),
  Server.hiKumoAsia: OverkizServer(
    name: 'Hitachi Hi Kumo (Asia)',
    endpoint: 'https://ha203-1.overkiz.com/enduser-mobile-web/enduserAPI/',
    manufacturer: 'Hitachi',
    configurationUrl: null,
  ),
  Server.hiKumoEurope: OverkizServer(
    name: 'Hitachi Hi Kumo (Europe)',
    endpoint: 'https://ha117-1.overkiz.com/enduser-mobile-web/enduserAPI/',
    manufacturer: 'Hitachi',
    configurationUrl: null,
  ),
  Server.hiKumoOceania: OverkizServer(
    name: 'Hitachi Hi Kumo (Oceania)',
    endpoint: 'https://ha203-1.overkiz.com/enduser-mobile-web/enduserAPI/',
    manufacturer: 'Hitachi',
    configurationUrl: null,
  ),
  Server.nexity: OverkizServer(
    name: 'Nexity Eugénie',
    endpoint: 'https://ha106-1.overkiz.com/enduser-mobile-web/enduserAPI/',
    manufacturer: 'Nexity',
    configurationUrl: null,
  ),
  Server.rexel: OverkizServer(
    name: 'Rexel Energeasy Connect',
    endpoint: 'https://ha112-1.overkiz.com/enduser-mobile-web/enduserAPI/',
    manufacturer: 'Rexel',
    configurationUrl: 'https://utilisateur.energeasyconnect.com/user/#/zone/equipements',
  ),
  Server.sauterCozytouch: OverkizServer(
    name: 'Sauter Cozytouch',
    endpoint: 'https://ha110-1.overkiz.com/enduser-mobile-web/enduserAPI/',
    manufacturer: 'Sauter',
    configurationUrl: null,
  ),
  Server.simuLivein2: OverkizServer(
    name: 'SIMU (LiveIn2)',
    endpoint: 'https://ha101-1.overkiz.com/enduser-mobile-web/enduserAPI/',
    manufacturer: 'Somfy',
    configurationUrl: null,
  ),
  Server.somfyEurope: OverkizServer(
    name: 'Somfy (Europe)',
    endpoint: 'https://ha101-1.overkiz.com/enduser-mobile-web/enduserAPI/',
    manufacturer: 'Somfy',
    configurationUrl: null,
  ),
  Server.somfyAmerica: OverkizServer(
    name: 'Somfy (North America)',
    endpoint: 'https://ha401-1.overkiz.com/enduser-mobile-web/enduserAPI/',
    manufacturer: 'Somfy',
    configurationUrl: null,
  ),
  Server.somfyOceania: OverkizServer(
    name: 'Somfy (Oceania)',
    endpoint: 'https://ha201-1.overkiz.com/enduser-mobile-web/enduserAPI/',
    manufacturer: 'Somfy',
    configurationUrl: null,
  ),
  Server.thermorCozytouch: OverkizServer(
    name: 'Thermor Cozytouch',
    endpoint: 'https://ha110-1.overkiz.com/enduser-mobile-web/enduserAPI/',
    manufacturer: 'Thermor',
    configurationUrl: null,
  ),
  Server.ubiwizz: OverkizServer(
    name: 'Ubiwizz',
    endpoint: 'https://ha129-1.overkiz.com/enduser-mobile-web/enduserAPI/',
    manufacturer: 'Decelect',
    configurationUrl: null,
  ),
};