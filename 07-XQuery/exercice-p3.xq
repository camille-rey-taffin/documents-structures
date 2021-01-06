declare namespace local = "docs-strucs-correction";

declare function local:normalise-texte($texte as xs:string) as xs:string* {

    let $ponctuations := "?!;.,'"""
    return translate($texte, $ponctuations, "") => lower-case() => tokenize(' ')
};

declare function local:calcul-frequence($mots as xs:string*) as element(mot)*{
    for $mot in distinct-values($mots)
    let $elem := <mot frequence ="{count($mots[. = $mot])}">{$mot}</mot>
    return $elem
};

let $texte := local:normalise-texte('Bonjour, je "suis" un texte de départ. Avec de la ponctuation.')
(:let $texte := unparsed-text('file:////Users/ap/Desktop/documents-structures/07-XQuery/test.txt'):)
let $freq := local:calcul-frequence($texte)
return <dictionnaire>{$freq}</dictionnaire>
