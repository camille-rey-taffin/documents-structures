<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
   
    <sch:pattern>
        <sch:rule abstract="true" id="contient-paragraphe">
            <sch:assert test="self::*[child::p]">L'élément <sch:name/> doit avoir un enfant p (paragraphe).</sch:assert>
        </sch:rule>
        
        <sch:rule context="TEI">
            <sch:assert test="teiHeader">Un document TEI doit contenir un élément teiHeader.</sch:assert>
            <sch:assert test="text">Un document TEI doit contenir un élement text.</sch:assert>
        </sch:rule>
        
        <sch:rule context="pdv">
            <sch:extends rule="contient-paragraphe"/>
        </sch:rule>
        
        <sch:rule context="projectDesc">
            <sch:extends rule="contient-paragraphe"/>
        </sch:rule>
        
    </sch:pattern>
    
    <sch:pattern abstract="true" id="head-scene">
        <sch:rule context="$element">
            <sch:assert test="count(child::head) = 1">L'élément <sch:name/> doit contenir un élément head.</sch:assert>
            <sch:assert test="count(child::div[@type='scene']) > 1">L'élément <sch:name/> doit contenir au moins deux éléments div de type scène.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern is-a="head-scene" id="div">
        <sch:param name="element" value="div[@type='act']"/>
    </sch:pattern>
    
    
</sch:schema>
