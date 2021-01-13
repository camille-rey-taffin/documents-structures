# -*- coding: utf-8 -*-
# script_transfo.py -- CamilleRey
# petit script pour effectuer la transfo xslt sur tous les documents en input

import lxml.etree as ET
import zipfile
import glob

namespaces = {'xsl': 'http://www.w3.org/1999/XSL/Transform', "meta" : "urn:oasis:names:tc:opendocument:xmlns:meta:1.0", "office" : "urn:oasis:names:tc:opendocument:xmlns:office:1.0"}

# pour tous les fichiers odt du répertoire input
for doc in glob.glob('./input/*.odt'):

        # on récupère le contenu des fichiers xml archivés content.xml et meta.xml
        # ces contenus sont parsés et stockés dans des objets e.tree de lxml
        with zipfile.ZipFile(f"{doc}") as arch_odt:
            content = ET.parse(arch_odt.open("content.xml",'r'))
            meta = ET.parse(arch_odt.open("meta.xml",'r'))
        # on parse et stocke la feuille de style xsl
        xslt = ET.parse("transformationV2.xsl")
        # on copie dans l'élément racine du xsl l'élément //office:meta contenu dans meta.xml
        # (c'est celui qui contient les éléments qui nous intéressent)
        xslt.getroot().append((meta.findall("//office:meta", namespaces)[0]))

        #on effectue la transformation
        transform = ET.XSLT(xslt)
        resultat = transform(content)

        #écriture du résultat dans le répertoire output
        resultat.write_output(f"output/{doc[8:-4]}.xml")
