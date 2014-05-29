Delphi 7 - Преработен от версия 2.21 с добавена връзка към SDispenser

commit 29 MAY 2014 - нетествана версия. 
Всички добавени от мен променливи и процедури започват с sd
Добавени са променливи в uGlobals включително и CientSocket за връзка със стартиран SDispenser. sdBase и sdTag

В юнита uRecepie в процедурите doDoseStart и doAbortDose се викат моите процедури sdStart и sdStop. 

в Load се смятат 
fQtyDose - количество фураж в едно бъркало
fDosesReq - брой бъркала
