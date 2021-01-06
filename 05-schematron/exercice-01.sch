<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    
    <sch:pattern >
        <sch:rule context="fermeture">
            <sch:assert test="not(text())">L'élément <sch:name/> ne doit pas contenir de texte.</sch:assert>
        </sch:rule>
        <sch:rule context="ouverture">
            <sch:assert test="@debut and @fin">L'élément <sch:name/> doit contenir un '@debut' et une '@fin'.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="ouverture">
            <sch:report test="@saufjour eq ''" role="warning">Ce point de vente devrait prendre des vacances.</sch:report>
        </sch:rule>
        <sch:rule context="ville">
            <sch:report test="upper-case(text()) ne text()" role="warning">La ville devrait être écrite en majuscules.</sch:report>
        </sch:rule>
    </sch:pattern>
    
</sch:schema>