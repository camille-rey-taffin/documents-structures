let $document := doc("file:////Users/ap/Desktop/documents-structures/07-XQuery/juicers.xml")

for $juicer in $document/juicers/juicer
    order by xs:float($juicer/cost)
    where contains($juicer/name, "Juicer")
return string($juicer/@id) || $juicer/cost/text()