<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    
    <sch:ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>
   
    <sch:pattern>
        <sch:rule abstract="true" id="contient-paragraphe">
            <sch:assert test="tei:p">L'élément <sch:name/> doit avoir un enfant p (paragraphe).</sch:assert>
        </sch:rule>
        
        <sch:rule context="tei:TEI">
            <sch:assert test="tei:teiHeader and tei:text">Un document TEI doit contenir un élément teiHeader et un élément text.</sch:assert>
        </sch:rule>
        
        <sch:rule context="tei:sp">
            <sch:extends rule="contient-paragraphe"/>
        </sch:rule>
        
        <sch:rule context="tei:projectDesc">
            <sch:extends rule="contient-paragraphe"/>
        </sch:rule>
        
    </sch:pattern>
    
    <sch:pattern abstract="true" id="head-scene">
        <sch:rule context="$element">
            <sch:assert test="count(tei:head) = 1">L'élément <sch:name/> doit contenir un élément head.</sch:assert>
            <sch:assert test="count(tei:div[@type='scene']) > 1">L'élément <sch:name/> doit contenir au moins deux éléments div de type scène.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern is-a="head-scene" id="div">
        <sch:param name="element" value="tei:div[@type='act']"/>
    </sch:pattern>
    
    
</sch:schema>
