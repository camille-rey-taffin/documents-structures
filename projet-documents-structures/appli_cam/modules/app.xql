xquery version "3.1";

module namespace app="http://www.digital-archiv.at/ns/appli_cam/templates";

declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace functx = 'http://www.functx.com';

import module namespace templates="http://exist-db.org/xquery/templates" ;
import module namespace config="http://www.digital-archiv.at/ns/appli_cam/config" at "config.xqm";
import module namespace kwic = "http://exist-db.org/xquery/kwic" at "resource:org/exist/xquery/lib/kwic.xql";

(:~
 : This is a sample templating function. It will be called by the templating module if
 : it encounters an HTML element with an attribute data-template="app:test" 
 : or class="app:test" (deprecated). The function has to take at least 2 default
 : parameters. Additional parameters will be mapped to matching request or session parameters.
 : 
 : @param $node the HTML node with the attribute which triggered this call
 : @param $model a map containing arbitrary data - used to pass information between template calls
 :)
 
declare function app:afficherDoc($doc) {
    let $nom_doc := util:document-name($doc)
    let $id_doc := replace ($nom_doc,'\.xml','')
    return
    <div class="col-md-6 col-lg-4 mb-5">
            <div class="portfolio-item mx-auto" data-toggle="modal" data-target="{concat("#",$id_doc)}">
                <div class="portfolio-item-caption d-flex align-items-center justify-content-center h-100 w-100">
                    <div class="portfolio-item-caption-content text-center text-white"><i class="fas fa-plus fa-3x"></i><p>{$nom_doc}</p></div>
                    </div>
                <img class="img-fluid" src="resources/images/livre.png" alt="" />
            </div>
            <div class="portfolio-modal modal fade" id="{$id_doc}" tabindex="-1" role="dialog" aria-labelledby="portfolioModal1Label" aria-hidden="true">
                        <div class="modal-dialog modal-xl" role="document">
                            <div class="modal-content">
                                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true"><i class="fas fa-times"></i></span>
                                </button>
                                <div class="modal-body text-center">
                                    <div class="container">
                                        <div class="row justify-content-center">
                                            <div class="col-lg-8">
                                                <!-- Portfolio Modal - Title-->
                                                <h2 class="portfolio-modal-title text-secondary text-uppercase mb-0" id="portfolioModal1Label">{$nom_doc}</h2>
                                                <!-- Icon Divider-->
                                                <div class="divider-custom">
                                                    <div class="divider-custom-line"></div>
                                                    <div class="divider-custom-icon"><i class="fas fa-lemon"></i></div>
                                                    <div class="divider-custom-line"></div>
                                                </div>
                                                <!-- Portfolio Modal - Text-->
                                                <p class="mb-5">{app:transfoTEI($nom_doc)}</p>
                                                <button class="btn btn-primary" data-dismiss="modal">
                                                    <i class="fas fa-times fa-fw"></i>
                                                    Fermer le document
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
            </div>
        </div>
};

declare function app:listerDocs($node as node(), $model as map(*)) {
    for $document in collection(concat($config:app-root, '/data/'))/tei:TEI
        return
        app:afficherDoc($document)
};
 
declare function app:transfoTEI ($doc_xml) {
    let $xml := doc(concat($config:app-root,"/data/",$doc_xml))
    let $xsl := doc(concat($config:app-root,"/resources/xslt/transfo_tei.xsl"))
    let $params :=
    <parameters>
    {for $p in request:get-parameter-names()
        let $val := request:get-parameter($p,())
        where  not($p = ("document","directory","stylesheet"))
        return
            <param name="{$p}"  value="{$val}"/>
    }
    </parameters>
return
    transform:transform($xml, $xsl, $params)
};



declare function app:chercher($node as node(), $model as map (*)) {
    if (request:get-parameter("keyword", "")="") then (
    if (request:get-parameter("date_pub", "")="" and request:get-parameter("livre", "")="" and request:get-parameter("auteur", "")="" and request:get-parameter("date_crea", "")="") then (
    <tr><td>--</td><td>--</td></tr>)
    else (
    let $livre as xs:string:= request:get-parameter("livre", "")
    let $auteur as xs:string:= request:get-parameter("auteur", "")
    let $date_crea as xs:string:= request:get-parameter("date_crea", "")
    let $date_pub as xs:string:= request:get-parameter("date_pub", "")
    for $hit in collection(concat($config:app-root, '/data/'))/tei:TEI[contains(lower-case(.//tei:title),lower-case($livre)) and contains(lower-case(.//tei:author),lower-case($auteur)) and contains(.//tei:creation/tei:date,$date_crea) and contains(.//tei:publicationStmt/tei:date,$date_pub)]
    return
    <tr>
        <td>--</td>
        <td>{util:document-name($hit)}</td>
    </tr>)
    )
    else (
    
    let $livre as xs:string:= request:get-parameter("livre", "")
    let $auteur as xs:string:= request:get-parameter("auteur", "")
    let $date_crea as xs:string:= request:get-parameter("date_crea", "")
    let $date_pub as xs:string:= request:get-parameter("date_pub", "")
    let $keyword as xs:string:= request:get-parameter("keyword", "")
    for $hit in collection(concat($config:app-root, '/data/'))//tei:TEI[contains(lower-case(.//tei:title),lower-case($livre)) and contains(lower-case(.//tei:author),lower-case($auteur)) and contains(.//tei:creation/tei:date,$date_crea) and contains(.//tei:publicationStmt/tei:date,$date_pub)]//tei:p[ft:query(.,$keyword)]
    let $document := document-uri(root($hit))
    let $score as xs:float := ft:score($hit)
    order by $score descending
    return
    <tr>
        <td>{kwic:summarize($hit, <config width="40" link="" />)}</td>
        <td>{util:document-name($hit)}</td>
    </tr>)
 };