<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">

    <!-- Ne pas oublier l'espace de noms de la TEI -->
    <sch:ns uri="http://www.tei-c.org/ns/1.0" prefix="t"/>
    
    <sch:pattern>
        <sch:rule context="t:TEI">
            <sch:assert test="t:teiHeader and t:text">
                Un élément <sch:name/> contient un élément teiHeader et un élément text.
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule abstract="true" id="contient-paragraphe">
            <sch:assert test="t:p">L'élément <sch:name/> doit contenir un élément p.</sch:assert>
        </sch:rule>
        
        <sch:rule context="t:sp">
            <sch:extends rule="contient-paragraphe"/>
        </sch:rule>
        
        <sch:rule context="t:projectDesc">
            <sch:extends rule="contient-paragraphe"/>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern abstract="true" id="structure-act">
        <sch:rule context="$act">
            <sch:assert test="$head">L'élément <sch:name/> doit avoir un élément head.</sch:assert>
            <sch:assert test="count($scene) > 1">L'élément <sch:name/> doit contenir au moins deux scènes.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern is-a="structure-act" id="act">
        <sch:param name="act" value="t:div[@type='act']"/>
        <sch:param name="head" value="t:head"/>
        <sch:param name="scene" value="t:div[@type='scene']"/>
    </sch:pattern>
</sch:schema>