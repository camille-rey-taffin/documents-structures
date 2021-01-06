declare namespace t = "http://www.tei-c.org/ns/1.0";
 
let $rom := doc('Rom.xml')

for $editor in $rom//t:editor

return $editor/text()