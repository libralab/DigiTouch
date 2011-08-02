﻿package {	import br.com.stimuli.loading.BulkLoader;	import br.com.stimuli.loading.BulkProgressEvent;	import flash.events.*;	import flash.display.*;	import flash.xml.*;	import flash.text.Font;	import flash.text.TextField;	import flash.text.TextFormat;	import flash.text.*;	import flash.events.MouseEvent;	import flash.net.*;	import flash.filters.DropShadowFilter;	//klasa widoku sektora stadionu	public class Element extends MovieClip	{		private var idNum:int;		private var MCs:Array;//tablica movieclipow element (glownych)		private var loader:BulkLoader;		private var xml:XML;		private var grupaXML:XML;		private var elementFolder:String;		private var buttonsWidth:int;		private var buttonsX:int;		static private var once:Boolean = true;		private var myLoader:Loader;		public var buttons:Array;//tablica movieclipow element (glownych)		private var dropShadow:DropShadowFilter = new DropShadowFilter();		public function Element(num:int,folder:String,elementXML:XML,gXML:XML):void		{			myLoader = new Loader  ;			buttons = new Array  ;			buttonsWidth = 220;			buttonsX = 35;			grupaXML = gXML;			//loader =  BulkLoader.getLoader("main-site");			loader = new BulkLoader(folder + String(num + 100));			idNum = num;			elementFolder = folder;			var podlogaFile:String = elementXML.podloga.attribute("src");			loader.add(folder + podlogaFile,{id:"podloga"});			loader.get("podloga").addEventListener(Event.COMPLETE,onPodlogaLoaded);//			dropShadow.distance = 0;			dropShadow.angle = 60;//			dropShadow.color = 0x333333;//			dropShadow.alpha = 1;//			dropShadow.blurX = 10;//			dropShadow.blurY = 10;//			dropShadow.strength = 1;//			dropShadow.quality = 15;//			dropShadow.inner = false;//			dropShadow.knockout = false;//			dropShadow.hideObject = false;			if (once)			{				//loader.add("banergorny/BannerRotatorFX.swf?folderPath=banergorny/listwy_okleinowane/", {id:"bannergorny" + idNum});				//loader.add("banergorny/BannerRotatorFX.swf", {id:"bannergorny"+ idNum});				//loader.get("bannergorny"+idNum).addEventListener(Event.COMPLETE, onBannerLoaded);				//this.loadmovie('banergorny/BannerRotatorFX.swf');				//var myLoader:Loader = new Loader();				//myLoader.load(new URLRequest("banergorny/BannerRotatorFX.swf"));				//myLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onBannerLoaded);				//trace("test");				once = false;				//var lc:LocalConnection = new LocalConnection  ;				//				//lc.client = this;				//lc.connect("__conn");				//var url:String = "banergorny/BannerRotatorFX.swf";				//var request:URLRequest = new URLRequest(url);				//				//var l:Loader = new Loader  ;				//l.load(request);				//l.y = 30;				//addChild(l);				//            var url:String = "http://www.[yourDomain].com/application.jsp";				//            var request:URLRequest = new URLRequest(url);				//            var variables:URLVariables = new URLVariables();				//            variables.exampleSessionId = new Date().getTime();				//            variables.exampleUserLabel = "guest";				//            request.data = variables;				//            navigateToURL(request);			}			loader.start();			var elementId:int;			var elementName:String;			var trybunaX:int;			var trybunaY:int;			var trybunaSrc:String;			var trybunaSrcH:String;			var trybunaURL:String;			for each (var elementTrybunyXML:XML in elementXML.trybuny.element)			{				if (int(elementTrybunyXML.attribute("x")) != 0)				{					trybunaX = int(elementTrybunyXML.attribute("x"));					trybunaY = int(elementTrybunyXML.attribute("y"));					trybunaSrc = elementTrybunyXML.attribute("src");					trybunaSrcH = elementTrybunyXML.attribute("src_hover");					trybunaURL = elementTrybunyXML.attribute("url");					var butt:ChairsButton = new ChairsButton(elementFolder,trybunaSrc,trybunaSrcH,trybunaURL);					butt.x = trybunaX;					butt.y = trybunaY;					this.addChild(butt);				}			}			var elementGroupList:XMLList = grupaXML.elementy.element;			//var zz:int = 0;			for each (var elementXML:XML in elementGroupList)			{				//trace(zz);				elementId = elementXML.attribute("id");				elementName = elementXML.attribute("name");				//trace(elementId);				//trace(elementName);				//private function textButton(string: String, xVar:int):SimpleButton				//trace(elementId);				var button:SimpleButton = textButton(elementName,elementId);				//button.addEventListener(MouseEvent.CLICK, clickBut);				buttons[elementId] = button;				//trace(elementXML);				//trace(elementFolder);			}		}		private function onPodlogaLoaded(event:Event):void		{			var bg:Bitmap = loader.getBitmap("podloga");			bg.y = 502;			addChild(bg);		}		private function onBannerLoaded(event:Event):void		{			//var banner:MovieClip = loader.getMovieClip("bannergorny" + idNum);			////banner.y = 102;			trace(myLoader.loaderInfo);			////addChild(banner);			//myLoader.name = "bg";			//myLoader.x = 100;			//myLoader.y = 120;			addChild(myLoader);		}		private function textButton(string:String,id:int):SimpleButton		{			//button off			var xVar:int = (id - 1) * 220;			//var xVar = 0;			//trace (xVar);			trace();			var tf:TextFormat = new TextFormat  ;			tf.color = 0xF2F1BC;			tf.font = "Verdana";			//tf.bold = true;			tf.size = 15;			tf.align = TextFormatAlign.CENTER;			var txt:TextField = new TextField  ;			txt.text = string;			//txt.x = 0;			txt.y = 3;			txt.autoSize = TextFieldAutoSize.CENTER;			txt.setTextFormat(tf);			var mcOff:MovieClip = new MovieClip  ;			mcOff.addChild(txt);			txt.x = (buttonsWidth - txt.textWidth) * 0.5 - 7;			//button on			var bgYellow:Sprite = new Sprite  ;			bgYellow.graphics.beginFill(0xF2F1BC);			bgYellow.graphics.drawRect( 0, 0, buttonsWidth, 30 );			var tfO:TextFormat = new TextFormat  ;			tfO.color = 0xF2F1BC;			tfO.font = "Verdana";			tfO.bold = true;			tfO.underline = true;			tfO.size = 14;			tfO.align = TextFormatAlign.CENTER;			var txtO:TextField = new TextField  ;			txtO.text = string;			//txtOn.x = 0;			txtO.y = 3;			//txtOver.width = bgYellow.width;			//txtOver.height = bgYellow.height;			txtO.autoSize = TextFieldAutoSize.CENTER;			txtO.setTextFormat(tfO);			txtO.filters = [dropShadow];			var mcO:MovieClip = new MovieClip  ;			//mcOn.addChild(bgYellow);			mcO.addChild(txtO);			txtO.x = (buttonsWidth - txt.textWidth) * 0.5 - 10;			// hover			var tfOver:TextFormat = new TextFormat  ;			tfOver.color = 0xF2F1BC;			tfOver.font = "Verdana";			tfOver.bold = true;			//tfOver.underline = true;			tfOver.size = 14;			tfOver.align = TextFormatAlign.CENTER;			//tfOver			//tfOver.			var txtOver:TextField = new TextField  ;			txtOver.text = string;			//txtOn.x = 0;			txtOver.y = 3;			//txtOver.width = bgYellow.width;			//txtOver.height = bgYellow.height;			txtOver.autoSize = TextFieldAutoSize.CENTER;			txtOver.filters = [dropShadow];			txtOver.setTextFormat(tfOver);			var mcOver:MovieClip = new MovieClip  ;			//mcOn.addChild(bgYellow);			mcOver.addChild(txtOver);			txtOver.x = (buttonsWidth - txt.textWidth) * 0.5 - 10;			var btn:SimpleButton = new SimpleButton  ;			//btn.upState = mcOn;			//btn.overState = mcOver;			//btn.downState = mcOff;			btn.upState = mcO;// wcisniety			btn.overState = mcOver;// hover			btn.downState = mcOff;// zwykly 			btn.hitTestState = mcOff;			btn.x = buttonsX + xVar;			btn.y = 267;			addChild(btn);			return btn;		}	}}//switch (id)//{//case 1 ://bgYellow.graphics.moveTo(0,-6.5);//bgYellow.graphics.lineTo(buttonsWidth,-2);//bgYellow.graphics.lineTo(buttonsWidth,30);//bgYellow.graphics.lineTo(0,30);//bgYellow.graphics.lineTo(0,-5);//break;//case 2 ://bgYellow.graphics.moveTo(0,-2);//bgYellow.graphics.lineTo(buttonsWidth,-2);//bgYellow.graphics.lineTo(buttonsWidth,30);//bgYellow.graphics.lineTo(0,30);//bgYellow.graphics.lineTo(0,-5);//break;//case 3 ://bgYellow.graphics.moveTo(0,-2);//bgYellow.graphics.lineTo(buttonsWidth,-2.7);//bgYellow.graphics.lineTo(buttonsWidth,30);//bgYellow.graphics.lineTo(0,30);//bgYellow.graphics.lineTo(0,-5);//break;//case 4 ://bgYellow.graphics.moveTo(0,-2.7);//bgYellow.graphics.lineTo(buttonsWidth,-8.5);//bgYellow.graphics.lineTo(buttonsWidth,30);//bgYellow.graphics.lineTo(0,30);//bgYellow.graphics.lineTo(0,-5);//break;//}//bgYellow.graphics.endFill();