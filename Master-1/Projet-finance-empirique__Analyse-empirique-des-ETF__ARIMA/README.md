<!DOCTYPE html>
<html lang="en">
<body>
    <div class="container">
        <h1>📊 Analyse empirique des ETF (ARIMA) - Finance 2024-2025</h1>
<strong>Contexte et objectif du projet</strong>
        
Ce projet s’inscrit dans le domaine de la finance empirique et vise à analyser les propriétés statistiques et économétriques des fonds négociés en bourse (ETF). L’objectif principal est de comprendre la dynamique des rendements de plusieurs ETF, d’évaluer leurs caractéristiques statistiques, et d’appliquer des modèles économétriques pour mieux appréhender leur comportement temporel.

<strong>Données utilisées</strong>

Les données utilisées sont des séries temporelles quotidiennes des prix de trois ETF : Amundi Index MSCI Emerging Markets UCITS ETF DR (AEME.PA), Amundi MSCI Europe Growth UCITS ETF Acc (CG9.PA), et Amundi MSCI Europe Value Factor UCITS ETF-C (CV9.PA). Ces données couvrent une période allant de 2017 à fin 2024.

<strong>Méthodologie et outils</strong>

L’analyse débute par des statistiques descriptives des rendements géométriques, accompagnées de tests de normalité (Jarque-Bera) et d’analyse des corrélations. Des tests de stationnarité (ADF, KPSS) sont ensuite appliqués pour vérifier les propriétés des séries temporelles. La modélisation économétrique est réalisée via des modèles ARIMA pour capturer les dynamiques des rendements. Enfin, un test de cointégration d’Engle et Granger est effectué pour étudier les relations de long terme entre les ETF. Les analyses ont été conduites à l’aide de Gretl.

<strong>Principaux résultats</strong>

Les rendements des ETF présentent une distribution non normale, avec une forte asymétrie et un excès de kurtosis, indiquant des événements extrêmes fréquents. Les séries de prix ne sont pas stationnaires, mais leurs premières différences le sont, validant l’utilisation des modèles ARIMA. Le test de cointégration révèle l’absence de relation de long terme stable entre les ETF étudiés.

<strong>Interprétation et implications</strong>

Ces résultats soulignent la complexité des dynamiques des actifs financiers et la nécessité d’utiliser des modèles adaptés pour la gestion de portefeuille et l’analyse des risques. La non-normalité des rendements et l’absence de cointégration montrent que les stratégies d’investissement doivent prendre en compte ces caractéristiques pour optimiser la prise de décision.

<strong>Compétences développées</strong>

Ce travail a permis de renforcer les compétences en analyse statistique, tests économétriques, modélisation de séries temporelles (modèle ARIMA), ainsi qu’en interprétation des résultats financiers.
</body>
</html>
