xquery version "3.1";

module namespace bjr="http://localhost:8080/exist/apps/hello/bjr";

declare function bjr:greeting($node as node(), $model as map(*)) as element(div){
    <div>
    <p>Ce fichier Xquery contient notre premier code.
    Il est compris dans l'espace de noms
    <code>module namespace bjr="http://localhost:8080/exist/apps/hello/bjr";</code>.
    Il est important d'indiquer cette ligne pour chaque nouveau fichier <code>.xql</code>.
    On déclare une fonction <code>bjr:greeting</code> avec deux paramètres :
    <code>$node as node()</code> et <code>$model as map(*)</code> qui sont toujours
    obligatoires. Ce sont des variables internes à eXist-db.
    En sortie de la fonction, nous allons retourner cet élément paragraphe.
    Cette fonction est appelée, en ajoutant sur un élément de <code>index.html</code>
    l'attribut <code>@data-template</code> qui aura pour valeur <code>"bjr:greeting"</code>.
    </p>
    <p>Pour que cette fonction soit appelée, modifier le fichier <code>view.xql</code>
    en ajoutant l'instruction suivante <code>import module namespace bjr="http://localhost:8080/exist/apps/hello/bjr" at "greeting.xql";</code>.
        </p>
    </div>
};

declare function bjr:greeting-someone($node as node(), $model as map(*), $name as xs:string) as element(div) {
    <div>
        <p>Dans cette seconde fonction <code>bjr:greeting-someone</code>, nous avons rajoutés un paramètre <code>$name as xs:string</code>.
    Celui-ci contient le nom d'une personne. Il est passé via le système de template en ajoutant
    un attribut <code>@data-template-name</code> sur l'élément qui appel cette fonction.
    Ce qui suit après le tiret est le nom de notre argument.
    </p>
    <p>Cette fonction va retournée la valeur : <code>Bonjour, $name</code>.
    </p>
    <p>Bonjour, {$name}!</p>
    <p>Essayez à votre tour de modifier la valeur de <code>name</code> et d'ajouter d'autres variables.</p>
    </div>
};

declare function bjr:greeting-user($node as node(), $model as map(*), $queryPrenom as xs:string?) {
    if ($queryPrenom) then
        <p>Bonjour, {$queryPrenom}</p>    
    else
        ()
};

declare function bjr:greeting-query($node as node(), $model as map(*)) {
    let $name := request:get-parameter("name", ())
    return if ($name) then
        <p>Bonjour, {$name}! Le paramètre est : <code>{request:get-query-string()}</code></p>    
    else
        <p>Pour l'instant, l'url ne contient pas le paramètre : <code>{request:get-query-string()}</code>
        </p>
};

