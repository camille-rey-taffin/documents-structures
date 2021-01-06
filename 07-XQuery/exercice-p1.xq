declare namespace local = "docs-structs";

declare function local:mot-to-loucherbem($mot as xs:string) as xs:string {
   let $voyelles := ('a', 'e', 'i', 'o', 'u', 'y')
   let $premiere-lettre := substring($mot, 1, 1)
   
   return 
   if ($premiere-lettre = $voyelles)
   then 'l' || $mot ||'bem'
   else 'l' || substring($mot, 2) || $premiere-lettre || 'em'
};

declare function local:phrase-to-loucherbem($phrase as xs:string*) as xs:string* {
    for $mot in tokenize($phrase, ' ')
        return local:mot-to-loucherbem($mot)
};

(:
let $mots := vocabulaire/mot/text()
for $mot in $mots
    return local:mot-to-loucherbem($mot)
:)
 
let $phrase := "Une phrase pour tester la fonction"
return local:phrase-to-loucherbem($phrase)