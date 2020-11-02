<?php echo $header; ?>
<?php $languageEncode = json_encode($languageArrey); ?>
<?php $langCommonEncode = json_encode($langfileCom['var']); ?>
<div id="content">
<?php
// module: Текст и Заголовки!
// version: 0.1 Comercial
// autor: Шуляк Роман   roma78sha@gmail.com   www.opencartforum.com/index.php?app=core&module=search&do=user_activity&search_app=downloads&mid=678008 ?>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/module.png" alt="" /> <img class="flag" src="view/image/flags/<?php echo $default_img_language; ?>" alt="Text and headers" title="<?php echo $lang_default_text; ?> <?php echo $default_directory_language; ?>" /> <?php echo $heading_title; ?></h1>
      <div class="sha-mbuttons"><a href="<?php echo $button_home; ?>" title="<?php echo $text_version; ?>" class="button_home" target="_blank">0.1.5.3</a></div><div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" id="form">
	  <div id="tab-module">
		<?php // контрольный блок; ?>
		<div id="control_block"><?php echo $first_entry; ?><?php echo $control_block; ?><div id="text_search"><input type="text" placeholder="<?php echo $text_search; ?>" onkeypress="thSubmitEnter(event);" name="" size="30"><div onclick="thTextSearchReset();" title="<?php echo $text_search_res; ?>" style="display:none" class="text_search_res ui-icon ui-icon-closethick"></div><div onclick="textSearch($('#text_search > input').val());" title="<?php echo $text_search_title; ?>" class="text_search_btn ui-icon ui-icon-triangle-1-e"></div></div></div>
        <div class="clr"></div>
		<div id="scan_result"></div>
        <div class="clr"></div>

        <div id="tab-language">
		  
		  <div id="directory" class="directory_tab htabs">
			<a href="#tab-directory-1" class="directory_double directory_double_all all" style="display:inline;"><?php echo $text_common; ?></a>
			<?php $nDir = 1; ?>
			<?php foreach ($languageArrey as $dirname => $directory) { ?>
			  <?php $nDir++; ?>
			  <?php if ($dirname == "module") { ?>
				<a href="#tab-directory-<?php echo $nDir; ?>" data-directoryid="<?php echo $nDir; ?>" class="start_selected directory_double directory_double_<?php echo $dirname; ?> selected"><?php echo $dirname; ?></a>
			  <?php } else { ?>
				<a href="#tab-directory-<?php echo $nDir; ?>" class="directory_double directory_double_<?php echo $dirname; ?>"><?php echo $dirname; ?></a>
			  <?php } ?>
			<?php } ?>
		  </div>

		  <div id="tab-directory-1" class="directory_double directory_double_all directory-1 directory">
			<!-- /* общие (common) */ -->
				<?php foreach ($langfileCom['var'] as $key0 => $com) { ?>
				  <div class="varblockcom varblockcom_<?php echo $key0; ?>" onclick='tahRedactCommonFile(this, "<?php echo $langfileCom['filename']; ?>", "<?php echo $key0; ?>");'><span class="file_var"><?php echo $key0; ?>&nbsp;=&nbsp;</span><span class="file_set"><xmp class="file_set_xmp"><?php echo $com; ?></xmp></span><span class="ui-icon ui-icon-pencil"></span><input type="text" class="file_input" name="" value='<?php print($com); ?>' size="50"><div class="result_somelanguage height1"></div></div>
				<?php } ?>
		  </div>
		  
		  <?php $nDir = 1; ?>
		  <?php foreach ($languageArrey as $dirname => $directory) { ?> 
			<?php $nDir++; ?>
			<div id="tab-directory-<?php echo $nDir; ?>" class="directory_double_<?php echo $dirname; ?> directory">
			  <div class="accordion">
			  <?php foreach ($directory as $key2 => $file) { ?>
				<h3 class="varname varname_<?php echo $dirname; ?>_<?php echo $key2; ?>"><?php echo $key2; ?><?php if (isset($file["heading_title"])) { ?>&nbsp;<span>(<?php echo $file["heading_title"]; ?>)</span><?php } ?></h3>
				<div>
				<?php foreach ($file as $key3 => $var) { ?>
				  <div class="varblock varblock_<?php echo $dirname; ?>_<?php echo $key2; ?>_<?php echo $key3; ?>" onclick='tahRedact(this, "<?php echo $default_directory_language; ?>", "<?php echo $dirname; ?>", "<?php echo $key2; ?>", "<?php echo $key3; ?>");'><span class="file_var"><?php echo $key3; ?>&nbsp;&nbsp;</span><span class="file_set"><xmp class="file_set_xmp"><?php echo $var; ?></xmp></span><span class="ui-icon ui-icon-pencil"></span><input type="text" class="file_input" name="" value='<?php print($var); ?>' size="50"><div class="result_somelanguage height1"></div></div>
				<?php } ?>
				</div>
			  <?php } ?>
			  </div>
			</div>
		  <?php } ?>
        </div>

      </div>
      </form>
	  
	  <form action="<?php echo $action; ?>" method="post" id="idloadzip"><input type="hidden" name="inloadzip" value=1></form>
	  
    </div>
	<div id="spin"></div>
  </div>
</div>
<script type="text/javascript"><!-- 

// дополнительные языковые переменные
var thSomeLanguage = {}, thBlockDiv;


$('#language a').tabs();
$('div.directory_tab a').tabs();
$("div.accordion").accordion({autoHeight:false});

/*= READY =*/
$(document).ready(function () {
  $("div.directory").hide();
  $("div.directory_tab > a").removeClass('selected');
  t = $("div.htabs > a.start_selected");
  $(t).addClass('selected');
  $(t).each(function(){
	t_id = $(this).attr('data-directoryid');
	$("#tab-directory-"+t_id).show();
  });
  
  // infoclose
  /* t_link = '<button onclick="$(this).parent(\'div.infoclose\').hide(\'slow\')">X</button>';
  $("div.infoclose").append(t_link);
  var clickcontent = 0;
  $("#tab-module").click(function(){
	clickcontent++;
	if(clickcontent > 1) {
	  $("div.infoclose").hide("slow");
	  $("#tab-module").unbind('click');
	}
	return false;
  }); */
});
  
// дополнение к tabs
function txhDoubleTabs() {
  t = $('a.directory_double.selected').html();
  if(t == "Общее") t = "all";
  $('a.directory_double.directory_double_'+t).addClass('selected');
  $('div.directory_double_'+t).show();
}

function tahRedact(th, v1, v2, v3, v4){
  // показать выбранный инпут
  $(th).children("span.file_set, span.ui-icon").hide();
  var v = 'var['+v1+']['+v2+']['+v3+']['+v4+']';
  var input = $(th).children("input.file_input");
  var size = input.val().length;
  var text = $(th).find("xmp.file_set_xmp").text();
  var flag_src = $('img.flag').attr('src');
  var flag = "<span onclick=\"someLanguageTH('" + v1 + "','" + v2 + "','" + v3 + "','" + v4 + "')\" class='flag_wrapp'><img src='" + flag_src + "' alt='Text and headers' title='<?php echo $some_language_text; ?>' /></span><span onclick=\"someLanguageTH('" + v1 + "','" + v2 + "','" + v3 + "','" + v4 + "')\" class='text_langbutton'>language</span>";
  input.fadeIn("3000").attr("name", v).attr('size',size+9).attr('value',text).before(flag);
  $(th).removeAttr('onclick').addClass("redact");
  $(th).children("span.text_langbutton").show("slow");
} 
function tahRedactCommonFile(th, filename, value){
  // показать выбранный инпут
  $(th).children("span.file_set, span.ui-icon").hide();
  var v = 'com[<?php echo $default_directory_language; ?>]['+filename+']['+value+']';
  var input = $(th).children("input.file_input");
  var size = input.val().length;
  var text = $(th).find("xmp.file_set_xmp").text();
  var flag_src = $('img.flag').attr('src');
  var flag = "<span onclick=\"thSomeLanguageCom('<?php echo $default_directory_language; ?>','" + filename + "','" + value + "')\" class='flag_wrapp'><img src='" + flag_src + "' alt='Text and headers' title='<?php echo $some_language_text; ?>' /></span><span onclick=\"thSomeLanguageCom('<?php echo $default_directory_language; ?>','" + filename + "','" + value + "')\" class='text_langbutton'>language</span>";
  input.fadeIn("3000").attr("name", v).attr('size',size+9).attr('value',text).before(flag);
  $(th).removeAttr('onclick').addClass("redact");
  $(th).children("span.text_langbutton").show("slow");
}

function someLanguageTH(v1, v2, v3, v4){
  // показать индикатор
  tahSpin();
  
  // передаём в глобальные блок div с этой переменной (куда потом положить/вывести)
  thBlockDiv = $("div.varblock_"+v2+"_"+v3+"_"+v4+" > div.result_somelanguage");
  
  // проверить есть ли уже такие переменные
  if(window.thSomeLanguage[v2] != undefined) {
	t = thSomeLanguage[v2];
	if(window.t[v3] != undefined){
	  // показываем сразу ("уже есть")
	  thOutputLanguage(v1, v2, v3, v4);
	}else{
	  thLanguageVar(v1, v2, v3, v4);
	}
  }else{
	// alert("нету ");
	// получить
	thLanguageVar(v1, v2, v3, v4);
  }
}

function thLanguageVar(v1, v2, v3, v4){
  $.ajax({
	url: '<?php echo htmlspecialchars_decode($tokensomelanguage); ?>&make=somelanguageth',
	data: 'v1='+v1+'&v2='+v2+'&v3='+v3+'&v4='+v4,
	type: 'post',
	// dataType: 'json',
	beforeSend: function(ret){
      // alert();
	},
	success: function(data){
      var parse = jQuery.parseJSON(data);
	  thSomeLanguage[v2] = parse.somelanguage[v2];
	},
	complete: function(jqXHR, textStatus){
	  // выводим языки
	  thOutputLanguage(v1, v2, v3, v4);
	},
	error: function(jqXHR, textStatus, errorThrown){
      alert('error');
	}
  });
}
// показать дополнительные языки
function thOutputLanguage(v1, v2, v3, v4){
  tahSpin(stop);
  t = "";
  i = -1;
  for(var lang in thSomeLanguage[v2][v3]) {
	i++;
	if(i > 2){i = 0; t += "<div class='clr'></div>";}
	t1 = thSomeLanguage[v2][v3][lang][v4];
	// t1_inner = t1.innerText;
	t += "<span class='input_more_item'><span class='flag_wrapp'>" + thfImage(lang) + "</span><input type='text' class='file_input_more' name='var[" + lang + "][" + v2 + "][" + v3 + "][" + v4 + "]' value='' size='23'><xmp style='display:none'>" + t1 + "</xmp></span>";
  }
  $(thBlockDiv).html(t).removeClass("height1").animate({opacity: "show"}, 1000);
  t2 = $(thBlockDiv).find("span.input_more_item");
  $(t2).each(function(indx, element){
	$(element).children("input.file_input_more").val($(element).children("xmp").text());
  });
}

/* ================================================================================= */
/*                                       com                                         */
/* ================================================================================= */
function thSomeLanguageCom(v1, v2, v4){
  // показать индикатор
  tahSpin();
  // v3 = "0";
  
  // передаём в глобальные блок div с этой переменной (куда потом положить/вывести)
  thBlockDiv = $("div.varblockcom_"+v4+" > div.result_somelanguage");
  
  // проверить есть ли уже такие переменные
  if(window.thSomeLanguage.all != undefined) {
	thOutputLanguageCom(v1, v2, v4);
  }else{
	// alert("нету ");
	// получить com
	thLanguageVarCom(v1, v2, v4);
  }
}
function thLanguageVarCom(v1, v2, v4){
  $.ajax({
	url: '<?php echo htmlspecialchars_decode($tokensomelanguage); ?>&make=somelanguagecomth',
	data: 'v1='+v1+'&v2='+v2+'&v4='+v4,
	type: 'post',
	// dataType: 'json',
	beforeSend: function(ret){
      // alert();
	},
	success: function(data){
      var parse = jQuery.parseJSON(data);
	  thSomeLanguage.all = parse.somelanguage;
	},
	complete: function(jqXHR, textStatus){
	  // выводим языки
	  thOutputLanguageCom(v1, v2, v4);
	},
	error: function(jqXHR, textStatus, errorThrown){
      alert('error');
	}
  });
}
// показать дополнительные языки all
function thOutputLanguageCom(v1, v2, v4){
  tahSpin(stop);
  t = "";
  i = -1;
  for(var lang in thSomeLanguage.all) {
	i++;
	if(i > 2){i = 0; t += "<div class='clr'></div>";}
	for(var t_name in thSomeLanguage.all[lang]){
	t1 = thSomeLanguage.all[lang][t_name][v4];
	  t += "<span class='input_more_item'><span class='flag_wrapp'>" + thfImage(lang) + "</span><input type='text' class='file_input_more' name='com[" + lang + "][" + t_name + "][" + v4 + "]' value='' size='23'><xmp style='display:none'>" + t1 + "</xmp></span>";
	}
  }
  $(thBlockDiv).html(t).removeClass("height1").animate({opacity: "show"}, 1000);
  t2 = $(thBlockDiv).find("span.input_more_item");
  $(t2).each(function(indx, element){
	$(element).children("input.file_input_more").val($(element).children("xmp").text());
  });
}


/* ================================================================================= */
/*                                       plus                                        */
/* ================================================================================= */
function thSubmitEnter(event){
  if (!event) { var event = window.event; }

    // Enter is pressed
    if (event.keyCode == 13) {
	  event.preventDefault();
	  textSearch(event.target.value);
	}
}

function tahSpin(tumbler){
  // включить или выключить, [tahSpin();] если ни чего нету- то включить , [tahSpin("#el", false);] иначе выключить
  if (tumbler || tumbler == false){
	$("#spin").spin(false);
  }else{
	$.fn.spin.presets.flower = {
	  lines: 15, // The number of lines to draw
	  length: 0, // The length of each line
	  width: 5, // The line thickness
	  radius: 14, // The radius of the inner circle
	  corners: 0.7, // Corner roundness (0..1)
	  rotate: 0, // The rotation offset
	  direction: 1, // 1: clockwise, -1: counterclockwise
	  color: '#000', // #rgb or #rrggbb or array of colors
	  speed: 1, // Rounds per second
	  trail: 60, // Afterglow percentage
	  shadow: true, // Whether to render a shadow
	  hwaccel: false, // Whether to use hardware acceleration
	  className: 'spinner', // The CSS class to assign to the spinner
	  zIndex: 2e9, // The z-index (defaults to 2000000000)
	  top: '50%', // Top position relative to parent
	  left: '50%' // Left position relative to parent
	}

	$("#spin").spin('flower');
  }
}

function thfImage(lang){
  switch (lang) {
   case "ukrainian":
      t = "ua";
      break
   case "arabic":
      t = "ae";
      break
   case "bulgarian":
      t = "bg";
      break
   case "danish":
      t = "dk";
      break
   case "english":
      t = "ai";
      break
   case "finnish":
      t = "fi";
      break
   case "german":
      t = "de";
      break
   case "italian":
      t = "ie";
      break
   case "latvian":
      t = "lv";
      break
   case "portuguese-br":
      t = "pt";
      break
   case "russian":
      t = "ru";
      break
   case "swedish":
      t = "se";
      break
   case "vietnamese":
      t = "vn";
      break
   default:
      t = false;
	  return "<span title='" + lang + "' class='short_lang'>" + lang + "</span>";
      break
  }
  return "<img src='view/image/flags/" + t + ".png' alt='Text and headers'>";
}

function textSearch(t){
  // alert(t);
  var t_arr = <?php echo $languageEncode; ?>; // alert(t_arr);
  var t_com_arr = <?php echo $langCommonEncode; ?>; // alert(t_arr);
  
  var str = "";
  // перебор
  for(var key in t_arr) {
  // key - название свойства
  // object[key] - значение свойства
  // alert(t_arr[key]);
	var thereIs=false;
	for(var key1 in t_arr[key]){
	  var thereIs1=false;
	  for(var key2 in t_arr[key][key1]){
		// alert(t_arr[key][key1][key2]);
		str = t_arr[key][key1][key2];
		if(str.indexOf(t) + 1) {
		  // alert("есть");
		  thereIs1=true;
		  $("#tab-language h3.varblock_"+key+"_"+key1+"_"+key2).addClass("ui-state-active");
		}else{
		  $("#tab-language .varblock_"+key+"_"+key1+"_"+key2).addClass("invisible");
		}
	  }
	  // если не было, ни чего найдено
	  if(!thereIs1){
		$("#tab-language .varname_"+key+"_"+key1).addClass("invisible");
		thereIs1=false;
	  }else{
		thereIs=true;
		thereIs1=false;
	  }
	}
	// если найдено в этом заголовке
	if(thereIs){
		$("#tab-language a.directory_double_"+key).addClass("pickout");
		thereIs=false;
	}
  }
  thereIs=false;
  for(var key2 in t_com_arr){
	str = t_com_arr[key2];
	if(str.indexOf(t) + 1){
	  thereIs=true;
	}else{
	  $("#tab-language .varblockcom_"+key2).addClass("invisible");
	}
  }
  // если найдено в этом заголовке (common)
  if(thereIs){
	$("#tab-language a.all").addClass("pickout");
	thereIs=false;
  }
  $("div.text_search_res").show();

}
function thTextSearchReset(){
  var t_arr = $("div#tab-language .directory");
  
  $("#text_search > input").val("");
  $("div#directory >a").removeClass("pickout");
  $(t_arr).each(function(indx, element){
	$(element).find(".invisible").removeClass("invisible");
  });
  $("div.text_search_res").hide();

}

//--></script> 
<?php echo $footer; ?>