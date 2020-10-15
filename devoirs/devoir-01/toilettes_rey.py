# -*- coding: utf-8 -*-
# toilettes_rey.py  -- CamilleRey
# transformer un fichier csv sur les toilettes de Paris en une représentation XML

import csv
from lxml import etree

#création de l'élement racine
racine = etree.Element("toilettes")

#création de tous les éléments "toilette" et sous-éléments, en parsant le fichier csv
with open("sanisettesparis.csv") as csvfile:
    reader = csv.DictReader(csvfile, delimiter=';',quotechar='"')
    for row in reader:
        toilette = etree.SubElement(racine, "toilette")
        toilette.attrib["type"]=row['TYPE']
        if row['STATUT']:
            toilette.attrib["statut"]=row['STATUT']
        adresse = etree.SubElement(toilette, "adresse")
        libelle = etree.SubElement(adresse, "libelle")
        libelle.text=row["ADRESSE"]
        arrondissement = etree.SubElement(adresse, "arrondissement")
        arrondissement.text=row["ARRONDISSEMENT"]
        horaire = etree.SubElement(toilette, "horaire")
        horaire.text=row["HORAIRE"]
        services=etree.SubElement(toilette,"services")
        acces=etree.SubElement(services,"acces-pmr")
        acces.text=row["ACCES_PMR"]
        relais=etree.SubElement(services,"relais-bebe")
        relais.text=row["RELAIS_BEBE"]
        equipement = etree.SubElement(toilette, "equipement")
        equipement.text=row["URL_FICHE_EQUIPEMENT"]

#écriture fichier sortie
with open("toilettes-paris.xml","wb") as file:
    file.write(etree.tostring(racine, xml_declaration=True, encoding="UTF-8",pretty_print=True,doctype="<!DOCTYPE toilettes SYSTEM 'wc.dtd'>"))
