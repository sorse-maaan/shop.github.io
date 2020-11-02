<?php
class ControllerModuleTextandheadings extends Controller {
// module: Текст и Заголовки!
// version: 0.1 Comercial
// autor: Шуляк Роман   roma78sha@gmail.com   www.opencartforum.com/index.php?app=core&module=search&do=user_activity&search_app=downloads&mid=678008
	private $error = array();

	public function index() {
		$this->language->load('module/textandheadings');

		$this->document->setTitle($this->language->get('heading_title'));
		$this->document->addStyle('view/stylesheet/textandheadings.css');
		$this->document->addScript('view/javascript/jquery/textandheadings/spin.min.js');
		$this->document->addScript('view/javascript/jquery/textandheadings/jquery.spin.js');

		// ДОСТУПНЫЕ сейчас языки
		$this->load->model('localisation/language');
		$languages = $this->model_localisation_language->getLanguages();

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			if(isset($this->request->post['inloadzip'])) {
			  if($this->request->post['inloadzip'] == 1) {
				if(file_exists(DIR_CATALOG . 'language/langbac.zip')) {
				  // отдаём файл на скачивание
				  header('Content-type: application/zip');
				  header('Content-Disposition: attachment; filename="langbac.zip"');
				  readfile(DIR_CATALOG . 'language/langbac.zip');
				}
			  }
			  return;
			}
			
			// сохранение
			if(isset($this->request->post['com'])){
			$com = $this->request->post['com'];
			  foreach ($com as $langname => $lang){
				foreach ($lang as $filename => $file){
				  foreach ($file as $varname => $var){
					$href = DIR_CATALOG."language/".$langname."/".$filename.".php";
					
					// 1- название переменной, например heading_title
					// 2- значение
					// 3- путь к файлу
					tahChangeTitle($varname, $var, $href);
				  } 
				}
			  }
			}

			if(isset($this->request->post['var'])){
			$postvar = $this->request->post['var'];

			foreach ($postvar as $lang => $var){
			  foreach ($var as $dirname => $dir){
				foreach ($dir as $filename => $file){
				  foreach ($file as $vname => $v){
					$href = DIR_CATALOG."language/".$lang."/".$dirname."/".$filename.".php"; 
					// var_dump($href);var_dump($vname);
					
					// 1- название переменной, например heading_title
					// 2- значение
					// 3- путь к файлу
					tahChangeTitle($vname, $v, $href);
				  }
				}
			  }
			}
			}
			
			$this->session->data['success'] = $this->language->get('text_success');
						
			// $this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}

		// текущий (по умолчанию) язык
		$default_language = $this->config->get('config_language');
		$default_directory_language = $languages[$default_language]["directory"];
		$default_filename_language = $languages[$default_language]["filename"];
				
		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_home'] = $this->language->get('homepagego');
		$this->data['text_common'] = $this->language->get('text_common');
		$this->data['text_search'] = $this->language->get('text_search');
		$this->data['text_search_title'] = $this->language->get('text_search_title');
		$this->data['lang_default_text'] = $this->language->get('lang_default_text');
		$this->data['some_language_text'] = $this->language->get('some_language_text');
		$this->data['text_search_res'] = $this->language->get('text_search_res');
		$this->data['text_version'] = $this->language->get('text_version');
		
		// backup
		$langbac = DIR_CATALOG . 'language/langbac.zip';
		$this->data['loadzip'] = $langbac;
		$control_block = ''; // '<div class="infoclose">'.$this->language->get('text_infoclose').'</div>'

		$lb_error = "";
		if (file_exists($langbac)) {
			// повторный вход
			// echo "файл уже существует!"; $lb_error .= "The file $langbac exists";
			$control_block .= $this->language->get('second_entry');
		} else {
			// первый вход
			// echo "The file $langbac does not exist";
			$lb_error .= $this->language->get('first_entry');

			// $post = $_POST;
			$file_folder = DIR_CATALOG . "language/"; // папка с файлами
			if(extension_loaded('zip')) {
			  $lb_files = glob($file_folder . '*/*.php');
			  $lb_files[] = glob($file_folder . '*/*/*.php');

			  if(isset($lb_files) and count($lb_files) > 0) {
				// проверяем выбранные файлы
				$zip = new ZipArchive(); // подгружаем библиотеку zip
				// $zip_name = time().".zip"; // имя файла
				$zip_name = $file_folder . "langbac.zip";
				if($zip->open($zip_name, ZIPARCHIVE::CREATE)!==TRUE) {
				  $lb_error .= "* Sorry ZIP creation failed at this time"; // echo '000' . $lb_error;
				}
				foreach($lb_files as $lb_dfile) {
				  if(gettype($lb_dfile) != "array") {
					$zip->addFile($lb_dfile);
				  } else {
					foreach($lb_dfile as $lb_file) {
					  $zip->addFile($lb_file); // добавляем файлы в zip архив
					}
				  }
				}
				$zip->close();
 
				if(file_exists($langbac)){
				  $lb_error .= $this->language->get('first_entry1');
				}

			} else
			  $lb_error .= "* Please select file to zip ";
			} else
			  $lb_error .= "* You dont have ZIP extension";
		}

		// echo "lb_error ".$lb_error;
		if (isset($lb_error) && strlen($lb_error) > 1) {
			$this->data['first_entry'] = '<div class="info">'.$lb_error.'</div>';
		} else {
			$this->data['first_entry'] = "";
		}
 
		if (isset($control_block)) {
			$this->data['control_block'] = $control_block;
		} else {
			$this->data['control_block'] = "";
		}
		// end backup
		
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->error['dimension'])) {
			$this->data['error_dimension'] = $this->error['dimension'];
		} else {
			$this->data['error_dimension'] = array();
		}
				
  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/textandheadings', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/textandheadings', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['tokensomelanguage'] = $this->url->link('module/textandheadings/thAjax', 'token=' . $this->session->data['token'], 'SSL');

		$languageArrey = array();

		  $langfile = DIR_CATALOG . 'language/' . $default_directory_language . '/' . $default_filename_language . '.php';
		  $langfileCom["filename"] = $default_filename_language;
		  $langfileCom["var"] = languageLoad($langfile);
		  
		  $dir = glob(DIR_CATALOG . 'language/' . $default_directory_language . '/*', GLOB_ONLYDIR);

		  foreach ($dir as $keys2 => $indir){
			$files = glob($indir . '/*.php');
			$dirname = basename($indir);

			foreach ($files as $keys3 => $file){
			  $filename = basename($file, '.php');
			  $contents = languageLoad($file);
			  $languageArrey[$dirname][$filename] = $contents;  
			}
		  }

		$this->data['languageArrey'] = $languageArrey;
		$this->data['langfileCom'] = $langfileCom; // var_dump($this->data['langfileCom']);
		$this->data['languages'] = $languages; // var_dump($languages);
		$this->data['default_directory_language'] = $default_directory_language; 
		$this->data['default_img_language'] = $languages[$default_language]["image"];
				
		$this->template = 'module/textandheadings.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
		
		// var_dump($this);
				
		$this->response->setOutput($this->render());
	}
	
	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/banner')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (isset($this->request->post['banner_module'])) {
			foreach ($this->request->post['banner_module'] as $key => $value) {
				if (!$value['width'] || !$value['height']) {
					$this->error['dimension'][$key] = $this->language->get('error_dimension');
				}			
			}
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
	
	function thAjax(){
		// если указан тип
		if(isset($this->request->get['make'])) {

		  // перебор типов post
		  if($this->request->get['make'] == "somelanguageth"){
			  $somelanguage = array();
			  $json = array();
			  
			  // директории с языками
			  $dir = glob(DIR_CATALOG . 'language/*', GLOB_ONLYDIR);
			  
			  foreach ($dir as $keys1 => $lang){
				$dirname = basename($lang);
				// если это не текущий
				if($dirname != $this->request->post['v1']){
				  $langfile = $lang . '/' . $this->request->post['v2'] . "/" . $this->request->post['v3'] . '.php';
				  
				  $contents = false;
				  if($langfile){
					$contents = languageLoad($langfile); // var_dump($contents);
				  }
				  
				  // если такой файл существует
				  if(!empty($contents) && isset($contents[$this->request->post['v4']])){
					$somelanguage[$this->request->post['v2']][$this->request->post['v3']][$dirname] = $contents;
				  }
				}
			  }

			  $json['somelanguage'] = $somelanguage;
			  // $this->response->setOutput(json_encode($json));
			  // return $json;
			  exit(json_encode($json));
		  // файл "общее"
		  }else if($this->request->get['make'] == "somelanguagecomth"){

			  // директории с языками
			  $dir = glob(DIR_CATALOG . 'language/*', GLOB_ONLYDIR);
			  $somelanguage = array();
			  $json = array();

			  foreach ($dir as $keys1 => $lang){
				$dirname = basename($lang);
				// если это не текущий
				if($dirname != $this->request->post['v1']){
				  $filename = glob(DIR_CATALOG . 'language/' . $dirname . '/*.php');
				  $langfile = false;
				  $langfilename = false;
				  if($filename){
					$langfile = $filename[0];
					$langfilename = basename($langfile, '.php');
				  }
				  $contents = false;
				  if($langfile){
					$contents = languageLoad($langfile);
				  }
				  // если такой файл существует
				  if($contents[$this->request->post['v4']]){
					// [директория][имя файла php]
					$somelanguage[$dirname][$langfilename] = $contents;
				  }
				}
			  }
			  $json['somelanguage'] = $somelanguage;
			  exit(json_encode($json));
		  }
		  return;
		}
	}
	
/* ========================================================================================== */
/* Получить на других языках                                                                  */
/* ========================================================================================== */ 
}
function languageLoad($file = ""){
  if (file_exists($file)) {
	$_ = array();
	
	include $file;
	
	return $_;
  } else {
	return false;
	// trigger_error('Error: Could not load language ' . $file . '!');
	//	exit();
  }
}

/* ========================================================================================== */
/* Замена                                                                                     */
/* ========================================================================================== */ 
function tahChangeTitle($for_edit = "", $v = "", $hr = ""){

  // искомая строка
  // $for_edit="heading_title";

  // на эту меняем
  $replace = "\$_['".$for_edit."'] = '" . htmlspecialchars_decode($v) . "';";
  $fopen=@file($hr);

  foreach($fopen as $key=>$value){
	if(substr_count($value,$for_edit)){
 
	  // добавка
	  // $replace .= " // " . $value; // str_replace(" ","",$value);
	  
	  $fopen[$key] = $replace.PHP_EOL;
	  file_put_contents($hr, join('', $fopen));
	}
  }

}

?>