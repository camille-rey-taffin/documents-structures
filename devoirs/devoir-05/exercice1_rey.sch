<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
        <sch:rule context="fermeture">
            <sch:assert test="not(./text())">Un élément <sch:name/> ne peut contenir de texte.</sch:assert>
        </sch:rule>
        <sch:rule context="ouverture">
            <sch:assert test="@debut and @fin">Un élément <sch:name/> doit contenir un attribut début et un attribut fin.</sch:assert>
            <sch:report test="string-length(@saufjour)=0" role="warn">
                Les pdv ouverts tous les jours devraient prendre des vacances.</sch:report>
        </sch:rule>
        <sch:rule context="ville">
            <sch:report test="upper-case(text())!=text()" role="warn">
                Le nom des villes devrait être en majuscule.</sch:report>
        </sch:rule>
    </sch:pattern>
    
       
</sch:schema>
