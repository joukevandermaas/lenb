Hoe nieuwe features toe te voegen/te testen
===========================================
1 Schrijf code in matlab/preperation/mainBuild_gpsdata_extended.m
  Dit bestand is messy, maar het toevoegen van de features begint rond
  regel 60, met AppendedData(...) = [point, ...

2 Pas het getal extraAttributes (regel 23) in dit bestand aan, verhoog het als je dingen
  toevoegt, verlaag het als je dingen weghaalt.

3 Pas dit getal aan naar hetzelfde als bij stap 2 in matlab/interpretation/interpret_result.m op regel 3.

4 Pas het getal op regel 25 in run_classifier.py aan. Dit getal moet zijn
  extraAttributes + 5

Als je stap 2, 3 of 4 overslaat werken de volgende stappen niet.

5 Run het bestand matlab/preperation/mainBuild_gpsdata_extended_classes.m
  Dit maakt de csv voor alle data en voor de data met klasse. Het maakt een
  beep als het klaar is (kan lang duren) of als er iets mis is.

6 Run het script run_classifier.py. Het maakt een beep als het klaar is.
  Als er errors zijn onder --Registering WEKA Editors-- is het geen probleem,
  zolang er geen java exceptions zijn.

7 Run het bestand matlab/interpretation/interpret_result.m
  Dit print een paar tabellen naar de console.
