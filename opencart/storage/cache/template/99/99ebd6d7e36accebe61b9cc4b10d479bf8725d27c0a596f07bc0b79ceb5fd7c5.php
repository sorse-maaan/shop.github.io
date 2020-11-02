<?php

use Twig\Environment;
use Twig\Error\LoaderError;
use Twig\Error\RuntimeError;
use Twig\Extension\SandboxExtension;
use Twig\Markup;
use Twig\Sandbox\SecurityError;
use Twig\Sandbox\SecurityNotAllowedTagError;
use Twig\Sandbox\SecurityNotAllowedFilterError;
use Twig\Sandbox\SecurityNotAllowedFunctionError;
use Twig\Source;
use Twig\Template;

/* default/template/extension/module/categorywall.twig */
class __TwigTemplate_7bb414a8f00aa71d19a18451c93f9c609519ec69210aaaff90a0eb5350a8641f extends \Twig\Template
{
    private $source;
    private $macros = [];

    public function __construct(Environment $env)
    {
        parent::__construct($env);

        $this->source = $this->getSourceContext();

        $this->parent = false;

        $this->blocks = [
        ];
    }

    protected function doDisplay(array $context, array $blocks = [])
    {
        $macros = $this->macros;
        // line 1
        echo "<style>
.odcatwall {
    background: #fff;
    overflow: auto;
    display: block;
    padding: 10px;
    text-align: center;
\tfont-size:1.4em;
\tborder:1px solid #ddd;
\tmargin-bottom:20px;
}
.odcatwallhref {
\tpadding-top:10px;
}
</style>
<div class=\"row\">
\t<div class=\"col-md-12\">
\t\t<h3 class=\"center h-title\">Our Products</h3>
\t</div>
  ";
        // line 20
        $context['_parent'] = $context;
        $context['_seq'] = twig_ensure_traversable(($context["categories"] ?? null));
        foreach ($context['_seq'] as $context["_key"] => $context["category"]) {
            // line 21
            echo "\t<div class=\"product-layout col-lg-3 col-md-3 col-sm-6 col-xs-12\">
\t\t<a class=\"odcatwall\" href=\"";
            // line 22
            echo twig_get_attribute($this->env, $this->source, $context["category"], "href", [], "any", false, false, false, 22);
            echo "\">
\t\t\t<div><img src=\"";
            // line 23
            echo twig_get_attribute($this->env, $this->source, $context["category"], "image", [], "any", false, false, false, 23);
            echo "\" /></div>
\t\t\t<div class=\"odcatwallhref\">";
            // line 24
            echo twig_get_attribute($this->env, $this->source, $context["category"], "name", [], "any", false, false, false, 24);
            echo "</div>
\t\t</a>
\t</div>
  ";
        }
        $_parent = $context['_parent'];
        unset($context['_seq'], $context['_iterated'], $context['_key'], $context['category'], $context['_parent'], $context['loop']);
        $context = array_intersect_key($context, $_parent) + $_parent;
        // line 28
        echo "</div>
";
    }

    public function getTemplateName()
    {
        return "default/template/extension/module/categorywall.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  83 => 28,  73 => 24,  69 => 23,  65 => 22,  62 => 21,  58 => 20,  37 => 1,);
    }

    public function getSourceContext()
    {
        return new Source("", "default/template/extension/module/categorywall.twig", "");
    }
}
