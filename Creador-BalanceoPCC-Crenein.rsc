##Generador de Balanceo de cargas.
#
##--------Configuracion de LAN--------##
#Definir Interfaces LAN.
:local InterfacesQueEntranAlBalance {"ether2"};
#
##--------Configuracion de Balanceo--------##
#Tipos posibles ("both-addresses", "both-addresses-and-ports", "src-address", "src-address-and-port").
:local TipoDePCC "both-addresses-and-ports";
#
##--------Configuracion de WAN--------##
#Definicion de peers
:local peer1 {nombredelpeer="P1-Proveedor1"; interfaz="ether1"; gateway="192.168.1.1"; cantidaddemarcas="2"};
:local peer2 {nombredelpeer="P2-Proveedor2"; interfaz="ether2"; gateway="192.168.2.1"; cantidaddemarcas="2"};
#Array de peers.
:local peers {$peer1; $peer2};
#
##--------Configuracion de NAT--------##
#Crear NATs con masquerade
:local CrearNatMasquerade 1; #-Opciones 1 crea NATs, opcion 0 no crea NATs
#
##--------Configuracion de Rutas--------##
#Crear NATs con masquerade
:local CrearRutas 1; #-Opciones 1 crea rutas, opcion 0 no crea rutas
#
#----------------------------------------------------------------------------------------------#
#
:local MarcasTotales 0;
##Calculo de marcas totales
:foreach peer in=[$peers] do={
	:set $MarcasTotales ($MarcasTotales + ($peer->"cantidaddemarcas"));
}
##Generador y creador de reglas.
#DeshabilitarMangle
/ip firewall mangle
add action=accept chain=prerouting comment=Deshabilitar-Mangle
#CreaAddressLists
:local RedesQueNoEntranAReglas [:len [/ip firewall address-list find list=FNM_RedesQueNoEntranAReglas]];
:if ($RedesQueNoEntranAReglas = 0) do={
	/ip firewall address-list
	add address=10.0.0.0/8 list=FNM_RedesQueNoEntranAReglas
	add address=172.16.0.0/12 list=FNM_RedesQueNoEntranAReglas
	add address=192.168.0.0/16 list=FNM_RedesQueNoEntranAReglas
	add address=100.64.0.0/10 list=FNM_RedesQueNoEntranAReglas
}
:local SitiosQueNoPuedenBalancearse [:len [/ip firewall address-list find list=M_SitiosQueNoPuedenBalancearse]];
:if ($SitiosQueNoPuedenBalancearse = 0) do={
	/ip firewall address-list
	add address=200.10.199.0/24 list=M_SitiosQueNoPuedenBalancearse
	add address=45.238.212.0/22 list=M_SitiosQueNoPuedenBalancearse
	add address=190.228.28.168/29 list=M_SitiosQueNoPuedenBalancearse
	add address=190.228.28.200/29 list=M_SitiosQueNoPuedenBalancearse
	add address=190.228.35.112/29 list=M_SitiosQueNoPuedenBalancearse
	add address=200.1.116.0/24 list=M_SitiosQueNoPuedenBalancearse
	add address=209.13.141.0/26 list=M_SitiosQueNoPuedenBalancearse
	add address=201.131.79.0/24 list=M_SitiosQueNoPuedenBalancearse
	add address=190.228.28.176/29 list=M_SitiosQueNoPuedenBalancearse
	add address=190.136.32.240/29 list=M_SitiosQueNoPuedenBalancearse
	add address=200.45.17.0/24 list=M_SitiosQueNoPuedenBalancearse
	add address=190.2.61.64/27 list=M_SitiosQueNoPuedenBalancearse
	add address=186.153.165.32/29 list=M_SitiosQueNoPuedenBalancearse
	add address=200.5.196.248/29 list=M_SitiosQueNoPuedenBalancearse
	add address=200.124.126.0/24 list=M_SitiosQueNoPuedenBalancearse
	add address=200.61.184.0/24 list=M_SitiosQueNoPuedenBalancearse
	add address=201.221.120.0/24 list=M_SitiosQueNoPuedenBalancearse
	add address=190.183.222.62 list=M_SitiosQueNoPuedenBalancearse
	add address=200.80.203.163 list=M_SitiosQueNoPuedenBalancearse
	add address=190.3.127.164 list=M_SitiosQueNoPuedenBalancearse
	add address=170.51.242.96 list=M_SitiosQueNoPuedenBalancearse
	add address=190.111.204.30 list=M_SitiosQueNoPuedenBalancearse
	add address=54.208.241.253 list=M_SitiosQueNoPuedenBalancearse
	add address=200.59.131.3 list=M_SitiosQueNoPuedenBalancearse
	add address=200.32.111.231 list=M_SitiosQueNoPuedenBalancearse
	add address=200.31.0.0/20 list=M_SitiosQueNoPuedenBalancearse
	add address=200.47.24.0/24 list=M_SitiosQueNoPuedenBalancearse
	add address=200.47.97.0/24 list=M_SitiosQueNoPuedenBalancearse
	add address=200.47.99.0/24 list=M_SitiosQueNoPuedenBalancearse
	add address=200.61.38.0/25 list=M_SitiosQueNoPuedenBalancearse
	add address=200.61.38.128/25 list=M_SitiosQueNoPuedenBalancearse
	add address=200.5.92.194 list=M_SitiosQueNoPuedenBalancearse
	add address=161.190.0.0/16 list=M_SitiosQueNoPuedenBalancearse
	add address=200.32.32.0/23 list=M_SitiosQueNoPuedenBalancearse
	add address=93.115.95.84 list=M_SitiosQueNoPuedenBalancearse
	add address=5.62.88.64/27 list=M_SitiosQueNoPuedenBalancearse
	add address=104.24.22.26 list=M_SitiosQueNoPuedenBalancearse
	add address=104.20.44.101 list=M_SitiosQueNoPuedenBalancearse
	add address=72.246.214.251 list=M_SitiosQueNoPuedenBalancearse
	add address=78.46.189.202 list=M_SitiosQueNoPuedenBalancearse
	add address=138.121.76.0/22 list=M_SitiosQueNoPuedenBalancearse
	add address=190.2.23.72/29 list=M_SitiosQueNoPuedenBalancearse
	add address=190.111.233.48/28 list=M_SitiosQueNoPuedenBalancearse
	add address=200.47.32.0/24 list=M_SitiosQueNoPuedenBalancearse
	add address=200.124.123.0/24 list=M_SitiosQueNoPuedenBalancearse
	add address=69.55.58.171 list=M_SitiosQueNoPuedenBalancearse
	add address=138.255.80.0/22 list=M_SitiosQueNoPuedenBalancearse
	add address=190.220.2.160/29 list=M_SitiosQueNoPuedenBalancearse
	add address=190.220.145.96/27 list=M_SitiosQueNoPuedenBalancearse
	add address=200.51.198.37 list=M_SitiosQueNoPuedenBalancearse
	add address=190.104.210.32/29 list=M_SitiosQueNoPuedenBalancearse
	add address=190.104.210.128/26 list=M_SitiosQueNoPuedenBalancearse
	add address=190.104.220.16/29 list=M_SitiosQueNoPuedenBalancearse
	add address=190.104.228.236/30 list=M_SitiosQueNoPuedenBalancearse
	add address=190.216.76.112/30 list=M_SitiosQueNoPuedenBalancearse
	add address=190.216.71.0/26 list=M_SitiosQueNoPuedenBalancearse
	add address=200.55.21.80/28 list=M_SitiosQueNoPuedenBalancearse
	add address=181.15.127.168/29 list=M_SitiosQueNoPuedenBalancearse
	add address=201.253.106.0/27 list=M_SitiosQueNoPuedenBalancearse
	add address=181.10.162.232/29 list=M_SitiosQueNoPuedenBalancearse
	add address=200.82.126.146 list=M_SitiosQueNoPuedenBalancearse
	add address=170.210.0.0/16 list=M_SitiosQueNoPuedenBalancearse
	add address=32.104.16.0/24 list=M_SitiosQueNoPuedenBalancearse
	add address=181.15.152.176/29 list=M_SitiosQueNoPuedenBalancearse
	add address=181.15.204.232/29 list=M_SitiosQueNoPuedenBalancearse
	add address=181.88.194.176/29 list=M_SitiosQueNoPuedenBalancearse
	add address=181.88.194.192/29 list=M_SitiosQueNoPuedenBalancearse
	add address=200.45.234.24/29 list=M_SitiosQueNoPuedenBalancearse
	add address=190.111.216.160/27 list=M_SitiosQueNoPuedenBalancearse
	add address=190.183.59.184/29 list=M_SitiosQueNoPuedenBalancearse
	add address=190.183.255.144/29 list=M_SitiosQueNoPuedenBalancearse
	add address=200.0.226.0/23 list=M_SitiosQueNoPuedenBalancearse
	add address=200.0.236.0/23 list=M_SitiosQueNoPuedenBalancearse
	add address=200.5.85.0/24 list=M_SitiosQueNoPuedenBalancearse
	add address=200.5.86.0/23 list=M_SitiosQueNoPuedenBalancearse
	add address=200.5.88.0/21 list=M_SitiosQueNoPuedenBalancearse
	add address=200.5.96.0/23 list=M_SitiosQueNoPuedenBalancearse
	add address=200.5.208.0/22 list=M_SitiosQueNoPuedenBalancearse
	add address=200.5.212.0/23 list=M_SitiosQueNoPuedenBalancearse
	add address=200.80.226.247 list=M_SitiosQueNoPuedenBalancearse
	add address=179.43.118.194 list=M_SitiosQueNoPuedenBalancearse
}
#ReglasBase
/ip firewall mangle
add action=accept chain=prerouting comment=RedesQueNoEntranAReglas \
	dst-address-list=FNM_RedesQueNoEntranAReglas src-address-list=\
	FNM_RedesQueNoEntranAReglas
add action=accept chain=prerouting comment=SitiosQueNoPuedenBalancearse \
	dst-address-list=M_SitiosQueNoPuedenBalancearse
#Reglas de control manual
/ip firewall mangle
:foreach ControlManual in=$peers do={
	add chain=prerouting src-address-list=("M_ForzarSalidaDeEstosOrigenesPor_".($ControlManual->"nombredelpeer")) action=mark-routing new-routing-mark=($ControlManual->"nombredelpeer") \
	passthrough=no comment=("ForzarSalidaDeEstosOrigenesPor_".($ControlManual->"nombredelpeer"))
	add chain=prerouting dst-address-list=("M_ForzarSalidaAEstosDestinos_".($ControlManual->"nombredelpeer")) action=mark-routing new-routing-mark=($ControlManual->"nombredelpeer") \
	passthrough=no comment=("ForzarSalidaAEstosDestinos_".($ControlManual->"nombredelpeer"))
}
#Crea jumps Balanceo
/ip firewall mangle
:foreach a in=$InterfacesQueEntranAlBalance do={
	add chain=prerouting in-interface=$a action=jump jump-target=Balanceo comment=Balanceo
}
#Crea reglas de Balanceo
:local markcount 0;
:foreach Balanceo in=$peers do={
	:for n from=1 to=($Balanceo->"cantidaddemarcas") do={
		add chain=Balanceo per-connection-classifier="$TipoDePCC:$MarcasTotales/$markcount" action=mark-connection new-connection-mark=($Balanceo->"nombredelpeer")
		:set $markcount ($markcount+1);
	};
}
#Crea Return Balanceo.
/ip firewall mangle add chain=Balanceo action=return
#Crea jumps Enrutamiento
/ip firewall mangle
:foreach a in=$InterfacesQueEntranAlBalance do={
	add chain=prerouting in-interface=$a action=jump jump-target=Enrutamiento comment=Enrutamiento
}
#Crea reglas Enrutamiento
/ip firewall mangle
:foreach Balanceo in=$peers do={
	add chain=Enrutamiento connection-mark=($Balanceo->"nombredelpeer") action=mark-routing new-routing-mark=($Balanceo->"nombredelpeer") passthrough=no
}
#Crea Retorno Enrutamiento.
/ip firewall mangle add chain=Enrutamiento action=return
#Limpia Rutas
:foreach Balanceo in=$peers do={
	:do {/ip route remove [/ip route find routing-mark=($Balanceo->"nombredelpeer")];} on-error={}
	:do {/ip route remove [/ip route find comment=($Balanceo->"nombredelpeer")];} on-error={}
}
#Creacion de rutas
:if ($CrearRutas = 1) do={
	#Crea gateways con marca.
	/ip route
	:foreach Balanceo in=$peers do={
		add gateway=($Balanceo->"gateway") routing-mark=($Balanceo->"nombredelpeer")
	}
	#Crea gateways sin marca.
	/ip route
	:local distance 1;
	:foreach Balanceo in=$peers do={
		add gateway=($Balanceo->"gateway") comment=($Balanceo->"nombredelpeer") distance=$distance
		:set $distance ($distance+1)
	}
}
#Limpia NATs
:foreach Balanceo in=$peers do={
	:do {/ip firewall nat remove [/ip firewall nat find comment=($Balanceo->"nombredelpeer")];} on-error={}
}
#Crea NATs.
:if ($CrearNatMasquerade = 1) do={
    /ip firewall nat
    :foreach Balanceo in=$peers do={
        add chain=srcnat out-interface=($Balanceo->"interfaz") action=masquerade comment=($Balanceo->"nombredelpeer");
    }
}