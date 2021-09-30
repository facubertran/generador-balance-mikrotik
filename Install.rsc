/system script
add name=GeneradorBalancePCC-Crenein source="##Generador de Balanceo de cargas.\r\
    \n#\r\
    \n##--------Configuracion de LAN--------##\r\
    \n#Definir Interfaces LAN.\r\
    \n:local InterfacesQueEntranAlBalance {\"ether2\"};\r\
    \n#\r\
    \n##--------Configuracion de Balanceo--------##\r\
    \n#Tipos posibles (\"both-addresses\", \"both-addresses-and-ports\", \"src-address\", \"src-address-and-port\").\r\
    \n:local TipoDePCC \"both-addresses-and-ports\";\r\
    \n#\r\
    \n##--------Configuracion de WAN--------##\r\
    \n#Definicion de peers\r\
    \n:local peer1 {nombredelpeer=\"P1-Proveedor1\"; interfaz=\"ether1\"; gateway=\"192.168.1.1\"; cantidaddemarcas=\"2\"};\r\
    \n:local peer2 {nombredelpeer=\"P2-Proveedor2\"; interfaz=\"ether2\"; gateway=\"192.168.2.1\"; cantidaddemarcas=\"2\"};\r\
    \n#Array de peers.\r\
    \n:local peers {\$peer1; \$peer2};\r\
    \n#\r\
    \n##--------Configuracion de NAT--------##\r\
    \n#Crear NATs con masquerade\r\
    \n:local CrearNatMasquerade 1; #-Opciones 1 crea NATs, opcion 0 no crea NATs\r\
    \n#\r\
    \n##--------Configuracion de Rutas--------##\r\
    \n#Crear NATs con masquerade\r\
    \n:local CrearRutas 1; #-Opciones 1 crea rutas, opcion 0 no crea rutas\r\
    \n#\r\
    \n#----------------------------------------------------------------------------------------------#\r\
    \n#\r\
    \n:local MarcasTotales 0;\r\
    \n##Calculo de marcas totales\r\
    \n:foreach peer in=[\$peers] do={\r\
    \n\t:set \$MarcasTotales (\$MarcasTotales + (\$peer->\"cantidaddemarcas\"));\r\
    \n}\r\
    \n##Generador y creador de reglas.\r\
    \n#DeshabilitarMangle\r\
    \n/ip firewall mangle\r\
    \nadd action=accept chain=prerouting comment=Deshabilitar-Mangle\r\
    \n#CreaAddressLists\r\
    \n:local RedesQueNoEntranAReglas [:len [/ip firewall address-list find list=FNM_RedesQueNoEntranAReglas]];\r\
    \n:if (\$RedesQueNoEntranAReglas = 0) do={\r\
    \n\t/ip firewall address-list\r\
    \n\tadd address=10.0.0.0/8 list=FNM_RedesQueNoEntranAReglas\r\
    \n\tadd address=172.16.0.0/12 list=FNM_RedesQueNoEntranAReglas\r\
    \n\tadd address=192.168.0.0/16 list=FNM_RedesQueNoEntranAReglas\r\
    \n\tadd address=100.64.0.0/10 list=FNM_RedesQueNoEntranAReglas\r\
    \n}\r\
    \n:local SitiosQueNoPuedenBalancearse [:len [/ip firewall address-list find list=M_SitiosQueNoPuedenBalancearse]];\r\
    \n:if (\$SitiosQueNoPuedenBalancearse = 0) do={\r\
    \n\t/ip firewall address-list\r\
    \n\tadd address=200.10.199.0/24 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=45.238.212.0/22 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=190.228.28.168/29 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=190.228.28.200/29 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=190.228.35.112/29 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=200.1.116.0/24 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=209.13.141.0/26 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=201.131.79.0/24 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=190.228.28.176/29 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=190.136.32.240/29 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=200.45.17.0/24 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=190.2.61.64/27 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=186.153.165.32/29 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=200.5.196.248/29 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=200.124.126.0/24 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=200.61.184.0/24 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=201.221.120.0/24 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=190.183.222.62 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=200.80.203.163 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=190.3.127.164 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=170.51.242.96 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=190.111.204.30 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=54.208.241.253 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=200.59.131.3 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=200.32.111.231 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=200.31.0.0/20 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=200.47.24.0/24 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=200.47.97.0/24 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=200.47.99.0/24 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=200.61.38.0/25 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=200.61.38.128/25 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=200.5.92.194 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=161.190.0.0/16 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=200.32.32.0/23 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=93.115.95.84 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=5.62.88.64/27 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=104.24.22.26 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=104.20.44.101 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=72.246.214.251 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=78.46.189.202 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=138.121.76.0/22 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=190.2.23.72/29 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=190.111.233.48/28 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=200.47.32.0/24 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=200.124.123.0/24 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=69.55.58.171 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=138.255.80.0/22 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=190.220.2.160/29 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=190.220.145.96/27 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=200.51.198.37 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=190.104.210.32/29 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=190.104.210.128/26 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=190.104.220.16/29 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=190.104.228.236/30 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=190.216.76.112/30 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=190.216.71.0/26 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=200.55.21.80/28 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=181.15.127.168/29 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=201.253.106.0/27 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=181.10.162.232/29 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=200.82.126.146 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=170.210.0.0/16 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=32.104.16.0/24 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=181.15.152.176/29 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=181.15.204.232/29 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=181.88.194.176/29 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=181.88.194.192/29 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=200.45.234.24/29 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=190.111.216.160/27 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=190.183.59.184/29 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=190.183.255.144/29 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=200.0.226.0/23 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=200.0.236.0/23 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=200.5.85.0/24 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=200.5.86.0/23 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=200.5.88.0/21 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=200.5.96.0/23 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=200.5.208.0/22 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=200.5.212.0/23 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=200.80.226.247 list=M_SitiosQueNoPuedenBalancearse\r\
    \n\tadd address=179.43.118.194 list=M_SitiosQueNoPuedenBalancearse\r\
    \n}\r\
    \n#ReglasBase\r\
    \n/ip firewall mangle\r\
    \nadd action=accept chain=prerouting comment=RedesQueNoEntranAReglas \\\r\
    \n\tdst-address-list=FNM_RedesQueNoEntranAReglas src-address-list=\\\r\
    \n\tFNM_RedesQueNoEntranAReglas\r\
    \nadd action=accept chain=prerouting comment=SitiosQueNoPuedenBalancearse \\\r\
    \n\tdst-address-list=M_SitiosQueNoPuedenBalancearse\r\
    \n#Reglas de control manual\r\
    \n/ip firewall mangle\r\
    \n:foreach ControlManual in=\$peers do={\r\
    \n\tadd chain=prerouting src-address-list=(\"M_ForzarSalidaDeEstosOrigenesPor_\".(\$ControlManual->\"nombredelpeer\")) action=m\
    ark-routing new-routing-mark=(\$ControlManual->\"nombredelpeer\") \\\r\
    \n\tpassthrough=no comment=(\"ForzarSalidaDeEstosOrigenesPor_\".(\$ControlManual->\"nombredelpeer\"))\r\
    \n\tadd chain=prerouting dst-address-list=(\"M_ForzarSalidaAEstosDestinos_\".(\$ControlManual->\"nombredelpeer\")) action=mark-\
    routing new-routing-mark=(\$ControlManual->\"nombredelpeer\") \\\r\
    \n\tpassthrough=no comment=(\"ForzarSalidaAEstosDestinos_\".(\$ControlManual->\"nombredelpeer\"))\r\
    \n}\r\
    \n#Crea jumps Balanceo\r\
    \n/ip firewall mangle\r\
    \n:foreach a in=\$InterfacesQueEntranAlBalance do={\r\
    \n\tadd chain=prerouting in-interface=\$a action=jump jump-target=Balanceo comment=Balanceo\r\
    \n}\r\
    \n#Crea reglas de Balanceo\r\
    \n:local markcount 0;\r\
    \n:foreach Balanceo in=\$peers do={\r\
    \n\t:for n from=1 to=(\$Balanceo->\"cantidaddemarcas\") do={\r\
    \n\t\tadd chain=Balanceo per-connection-classifier=\"\$TipoDePCC:\$MarcasTotales/\$markcount\" action=mark-connection new-conne\
    ction-mark=(\$Balanceo->\"nombredelpeer\")\r\
    \n\t\t:set \$markcount (\$markcount+1);\r\
    \n\t};\r\
    \n}\r\
    \n#Crea Return Balanceo.\r\
    \n/ip firewall mangle add chain=Balanceo action=return\r\
    \n#Crea jumps Enrutamiento\r\
    \n/ip firewall mangle\r\
    \n:foreach a in=\$InterfacesQueEntranAlBalance do={\r\
    \n\tadd chain=prerouting in-interface=\$a action=jump jump-target=Enrutamiento comment=Enrutamiento\r\
    \n}\r\
    \n#Crea reglas Enrutamiento\r\
    \n/ip firewall mangle\r\
    \n:foreach Balanceo in=\$peers do={\r\
    \n\tadd chain=Enrutamiento connection-mark=(\$Balanceo->\"nombredelpeer\") action=mark-routing new-routing-mark=(\$Balanceo->\"\
    nombredelpeer\") passthrough=no\r\
    \n}\r\
    \n#Crea Retorno Enrutamiento.\r\
    \n/ip firewall mangle add chain=Enrutamiento action=return\r\
    \n#Limpia Rutas\r\
    \n:foreach Balanceo in=\$peers do={\r\
    \n\t:do {/ip route remove [/ip route find routing-mark=(\$Balanceo->\"nombredelpeer\")];} on-error={}\r\
    \n\t:do {/ip route remove [/ip route find comment=(\$Balanceo->\"nombredelpeer\")];} on-error={}\r\
    \n}\r\
    \n#Creacion de rutas\r\
    \n:if (\$CrearRutas = 1) do={\r\
    \n\t#Crea gateways con marca.\r\
    \n\t/ip route\r\
    \n\t:foreach Balanceo in=\$peers do={\r\
    \n\t\tadd gateway=(\$Balanceo->\"gateway\") routing-mark=(\$Balanceo->\"nombredelpeer\")\r\
    \n\t}\r\
    \n\t#Crea gateways sin marca.\r\
    \n\t/ip route\r\
    \n\t:local distance 1;\r\
    \n\t:foreach Balanceo in=\$peers do={\r\
    \n\t\tadd gateway=(\$Balanceo->\"gateway\") comment=(\$Balanceo->\"nombredelpeer\") distance=\$distance\r\
    \n\t\t:set \$distance (\$distance+1)\r\
    \n\t}\r\
    \n}\r\
    \n#Limpia NATs\r\
    \n:foreach Balanceo in=\$peers do={\r\
    \n\t:do {/ip firewall nat remove [/ip firewall nat find comment=(\$Balanceo->\"nombredelpeer\")];} on-error={}\r\
    \n}\r\
    \n#Crea NATs.\r\
    \n:if (\$CrearNatMasquerade = 1) do={\r\
    \n    /ip firewall nat\r\
    \n    :foreach Balanceo in=\$peers do={\r\
    \n        add chain=srcnat out-interface=(\$Balanceo->\"interfaz\") action=masquerade comment=(\$Balanceo->\"nombredelpeer\");\
    \r\
    \n    }\r\
    \n}"
