Om alles te kunnen gebruiken
===========================================
- Python moet geinstalleerd zijn (ik heb versie 3.x)
- Java moet geinstalleerd zijn.
- Weka moet geinstalleerd zijn.
- Weka moet aan je java classpath zijn toegevoegd (google het).

Hoe nieuwe features toe te voegen/te testen
===========================================
1 Schrijf code in matlab/prep_tables/build_trajectory_attributes.m

2 Pas de variabele header bovenaan dit bestand aan voor de nieuwe features.

3 Verander het getal extraAttributes in matlab/interpretation/interpret_result.m

4 Pas het getal op regel 9 in run_classifier.py aan. Dit getal moet zijn
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
