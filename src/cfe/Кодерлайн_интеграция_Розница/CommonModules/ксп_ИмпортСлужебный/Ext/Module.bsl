﻿
// Возвращает ссылку справочника по GUID
//
// Параметры:
//	УзелСсылки 	- структура - тэг из формата обмена (Json)
//	ВидСправочника - строка - Вид справочника из базы-приемника, например, Номенклатура
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ПолучитьСсылкуСправочникаСПроверкой(УзелСсылки, ВидСправочника) Экспорт

	Ref = "";
	Если УзелСсылки.Свойство("ref", Ref) Тогда
		Возврат Справочники[ВидСправочника].ПолучитьСсылку(
			Новый УникальныйИдентификатор(Ref));
	КонецЕсли;
		
	Возврат Неопределено;
	
КонецФункции

// Возвращает ссылку документа по GUID
//
// Параметры:
//	УзелСсылки 	- структура - 
//	ВидДокумента - строка - например, ПеремещениеТоваров
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ПолучитьСсылкуДокументаСПроверкой(УзелСсылки, ВидДокумента) Экспорт

	Ref = "";
	Если УзелСсылки.Свойство("ref", Ref) Тогда
		Возврат Документы[ВидДокумента].ПолучитьСсылку(
			Новый УникальныйИдентификатор(Ref));
	КонецЕсли;
		
	Возврат Неопределено;
	
КонецФункции


// Добавляет записи в регистры сведений:
// ксп_ОтложенноеПроведение
// ксп_ОтложенноеПроведениеПроблемы
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
Процедура ДобавитьПроблемуОтложенногоПроведения(ДанныеСсылка, ИмяРеквизита, ИмяТаблЧасти=Неопределено, НомерСтрокиТЧ=0, ВидПроблемы) Экспорт
	
	
	НЗ = РегистрыСведений.ксп_ОтложенноеПроведение.СоздатьНаборЗаписей();
	НЗ.Отбор.ДокументСсылка.Установить(ДанныеСсылка);
	
	НЗ.Прочитать();
	Если НЗ.Количество() > 0 Тогда
		
		стрк = НЗ[0];
		
	Иначе 
		
		стрк = НЗ.Добавить();
		стрк.ДокументСсылка = ДанныеСсылка;
			
	КонецЕсли; 

	
	
	Если ВидПроблемы = Перечисления.ксп_ВидыПроблемКачестваДокументов.НетЗначения Тогда
		стрк.СтатусОбъекта = Перечисления.ксп_СтатусыКачестваДокументов.Ошибка;
		
	ИначеЕсли ВидПроблемы = Перечисления.ксп_ВидыПроблемКачестваДокументов.БитаяСсылка Тогда
		стрк.СтатусОбъекта = Перечисления.ксп_СтатусыКачестваДокументов.Ожидание;
		
	КонецЕсли; 
	
	
	
	НЗ.Записать();
	
	//--------------------------------------------
	
	Если ВидПроблемы = Перечисления.ксп_ВидыПроблемКачестваДокументов.НетЗначения Тогда
	ИначеЕсли ВидПроблемы = Перечисления.ксп_ВидыПроблемКачестваДокументов.БитаяСсылка Тогда
		
	КонецЕсли; 
	
	НЗ = РегистрыСведений.ксп_ОтложенноеПроведениеПроблемы.СоздатьНаборЗаписей();
	НЗ.Отбор.ДокументСсылка.Установить(ДанныеСсылка);
	НЗ.Отбор.ИмяРеквизита.Установить(ИмяРеквизита);
	НЗ.Отбор.ИмяТаблЧасти.Установить(ИмяТаблЧасти);
	НЗ.Отбор.НомерСтрокиТЧ.Установить(НомерСтрокиТЧ);
	
	НЗ.Прочитать();
	Если НЗ.Количество() > 0 Тогда
		
		стрк = НЗ[0];
		
	Иначе 
		
		стрк = НЗ.Добавить();
		стрк.ДокументСсылка = ДанныеСсылка;
		стрк.ИмяРеквизита = ИмяРеквизита;
		стрк.ИмяТаблЧасти = ИмяТаблЧасти;
		стрк.НомерСтрокиТЧ = НомерСтрокиТЧ;
		
	КонецЕсли;
	
	стрк.ОписаниеПроблемы = "";
	стрк.ВидПроблемы = ВидПроблемы;
	
	НЗ.Записать();
		
КонецПроцедуры

// ПРоблем нет, добавляем документ к отложенному проведению
Процедура ДобавитьОтложенноеПроведение(ДанныеСсылка) Экспорт
	
	НЗ = РегистрыСведений.ксп_ОтложенноеПроведение.СоздатьНаборЗаписей();
	НЗ.Отбор.ДокументСсылка.Установить(ДанныеСсылка);
	
	НЗ.Прочитать();
	Если НЗ.Количество() > 0 Тогда
		
		стрк = НЗ[0];
		
	Иначе 
		
		стрк = НЗ.Добавить();
		стрк.ДокументСсылка = ДанныеСсылка;
			
	КонецЕсли; 
	
	стрк.СтатусОбъекта = Перечисления.ксп_СтатусыКачестваДокументов.ОК;
	
	НЗ.Записать();
	
	// очистим детали проблемы, если были
	
	НЗ = РегистрыСведений.ксп_ОтложенноеПроведениеПроблемы.СоздатьНаборЗаписей();
	НЗ.Отбор.ДокументСсылка.Установить(ДанныеСсылка);
	НЗ.Записать();
		
КонецПроцедуры

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ПроверитьКачествоДанных(ДокументОбъект, ОбъектОбработкиИмпорта) Экспорт
	
	// проверить шапку

	ЕстьПроблемы = Ложь;
	Для каждого рек Из МассивРеквизитовШапкиДляПроверки(ДокументОбъект, ОбъектОбработкиИмпорта) Цикл
		
		Если НЕ ЗначениеЗаполнено(ДокументОбъект[рек]) Тогда
			
			ксп_ИмпортСлужебный.ДобавитьПроблемуОтложенногоПроведения(
				ДокументОбъект.Ссылка, рек, Неопределено, 0, 
				Перечисления.ксп_ВидыПроблемКачестваДокументов.НетЗначения);
				
			ЕстьПроблемы = Истина;
			
		ИначеЕсли ЗначениеЗаполнено(ДокументОбъект[рек]) 
			И НЕ ЗначениеЗаполнено(ДокументОбъект[рек].ВерсияДанных) Тогда

			ксп_ИмпортСлужебный.ДобавитьПроблемуОтложенногоПроведения(
				ДокументОбъект.Ссылка, рек, Неопределено, 0, 
				Перечисления.ксп_ВидыПроблемКачестваДокументов.БитаяСсылка);
				
			ЕстьПроблемы = Истина;
		КонецЕсли;
		
	КонецЦикла;
	
	// todo проверить все Табл Части
	
	
	// в конце - финальная проверка на наличие проблем
	Если НЕ ЕстьПроблемы Тогда
		ксп_ИмпортСлужебный.ДобавитьОтложенноеПроведение(ДокументОбъект.Ссылка);
	КонецЕсли;
		
	Возврат Неопределено;
	
КонецФункции

Функция МассивРеквизитовШапкиДляПроверки(ДокументОбъект, ОбъектОбработкиИмпорта) Экспорт
	
	//ПолноеИмя = ДокументОбъект.Метаданные().ПолноеИмя();
	//Если ПолноеИмя = "ЗаказПокупателя" Тогда
	//	Возврат МассивРеквизитовШапкиДляПроверки_ЗаказПокупателя();
	//КонецЕсли;
	
	Возврат ОбъектОбработкиИмпорта.МассивРеквизитовШапкиДляПроверки();
	Возврат Новый Массив;
	
КонецФункции

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция МассивРеквизитовШапкиДляПроверки_ЗаказПокупателя() Экспорт
	
	мРеквизиты = Новый Массив;
	мРеквизиты.Добавить("Склад");
	мРеквизиты.Добавить("Организация");
	Возврат мРеквизиты;
	
КонецФункции


// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиБанковскийСчет(НомерСчета, БИК) Экспорт
		
	Банк = НайтиБанк(БИК);
	Если НЕ ЗначениеЗаполнено(Банк) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	БанковскиеСчета.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.БанковскиеСчета КАК БанковскиеСчета
		|ГДЕ
		|	БанковскиеСчета.НомерСчета = &НомерСчета
		|	И БанковскиеСчета.Банк = &Банк";
	
	Запрос.УстановитьПараметр("НомерСчета", НомерСчета);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Возврат ВыборкаДетальныеЗаписи.ссылка;
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции
 // Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиБанк(БИК) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	КлассификаторБанков.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.КлассификаторБанков КАК КлассификаторБанков
		|ГДЕ
		|	КлассификаторБанков.Код = &Код";
	
	Запрос.УстановитьПараметр("Код", БИК);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Возврат ВыборкаДетальныеЗаписи.Ссылка;
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции


// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиДисконтнуюКарту(Штрихкод, МагнитныйКод) Экспорт

	Если ЗначениеЗаполнено(МагнитныйКод) Тогда
		Запрос = Новый Запрос;
		Запрос.Текст = 
			"ВЫБРАТЬ
			|	ИнформационныеКарты.Ссылка КАК Ссылка
			|ИЗ
			|	Справочник.ИнформационныеКарты КАК ИнформационныеКарты
			|ГДЕ
			|	ИнформационныеКарты.КодКарты = &КодКарты";
		
		Запрос.УстановитьПараметр("КодКарты", МагнитныйКод);
		
		РезультатЗапроса = Запрос.Выполнить();
		
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			Возврат ВыборкаДетальныеЗаписи.Ссылка;
		КонецЦикла;
	КонецЕсли;

	Если ЗначениеЗаполнено(Штрихкод) Тогда
		Запрос = Новый Запрос;
		Запрос.Текст = 
			"ВЫБРАТЬ
			|	Штрихкоды.Владелец КАК ИнфКарта
			|ИЗ
			|	РегистрСведений.Штрихкоды КАК Штрихкоды
			|ГДЕ
			|	Штрихкоды.Штрихкод = &Штрихкод";
		
		Запрос.УстановитьПараметр("Штрихкод", Штрихкод);
		
		РезультатЗапроса = Запрос.Выполнить();
		
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			Возврат ВыборкаДетальныеЗаписи.ИнфКарта;
		КонецЦикла;
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции

// Описание_метода
//
// Параметры:
//	ТипыНалогообложенияНДС 	- строка/структура - перечисление в ЕРП "ТипыНалогообложенияНДС"
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция УчитыватьНДС(ТипыНалогообложенияНДС)   Экспорт
 
	Если ТипЗнч(ТипыНалогообложенияНДС) = Тип("Структура") Тогда
		_ТипыНалогообложенияНДС = ТипыНалогообложенияНДС.Значение;
	Иначе 
		_ТипыНалогообложенияНДС = ТипыНалогообложенияНДС;
	КонецЕсли;
	
	Если _ТипыНалогообложенияНДС =  "НалоговыйАгентПоНДС" Тогда
		Возврат Истина;
	ИначеЕсли _ТипыНалогообложенияНДС =  "ПоФактическомуИспользованию" Тогда
		Возврат Истина;
	ИначеЕсли _ТипыНалогообложенияНДС =  "ПродажаНаЭкспорт" Тогда
		Возврат Истина;
	ИначеЕсли _ТипыНалогообложенияНДС =  "ПродажаНеОблагаетсяНДС" Тогда
		Возврат Ложь;
	ИначеЕсли _ТипыНалогообложенияНДС =  "ПродажаОблагаетсяЕНВД" Тогда
		Возврат Ложь;
	ИначеЕсли _ТипыНалогообложенияНДС =  "ПродажаОблагаетсяНДС" Тогда
		Возврат Истина;
	ИначеЕсли _ТипыНалогообложенияНДС =  "ЭкспортСырьевыхТоваровУслуг" Тогда
		Возврат Истина;
	ИначеЕсли _ТипыНалогообложенияНДС =  "ЭкспортНесырьевыхТоваров" Тогда
		Возврат Истина;
	ИначеЕсли _ТипыНалогообложенияНДС =  "ВводОСВЭксплуатацию" Тогда
		Возврат Истина;
	ИначеЕсли _ТипыНалогообложенияНДС =  "ОпределяетсяРаспределением" Тогда
		Возврат Истина;
	ИначеЕсли _ТипыНалогообложенияНДС =  "ОблагаетсяНДСУПокупателя" Тогда
		Возврат Истина;
	ИначеЕсли _ТипыНалогообложенияНДС =  "ПроизводствоСДЦ" Тогда
		Возврат Истина;
	ИначеЕсли _ТипыНалогообложенияНДС =  "ЭлектронныеУслуги" Тогда
		Возврат Истина;
	ИначеЕсли _ТипыНалогообложенияНДС =  "РеализацияРаботУслугНаЭкспорт" Тогда
		Возврат Истина;
	ИначеЕсли _ТипыНалогообложенияНДС =  "ПродажаПоПатенту" Тогда
		Возврат Ложь;
	ИначеЕсли _ТипыНалогообложенияНДС =  "РеверсивноеОбложениеНДС" Тогда
		Возврат Истина;
		
	КонецЕсли;

	Возврат ЛОЖЬ;
	
КонецФункции



// Описание_метода
//
// Параметры:
//	УзелСправочника 	- строка - Узел справочника СтавкиНДС из ЕРП
//		Например, для номенклатуры:
 //      "СтавкаНДС": {
 //           "type": "Справочник.СтавкиНДС",
 //           "Ref": "5352d82a-eda6-11ed-8b9e-04ed33c124eb",
 //           "isFolder": false,
 //           "Code": "",
 //           "ПеречислениеСтавкаНДС": {
 //               "type": "Перечисление.СтавкиНДС",
 //               "Значение": "НДС20",
 //               "Представление": "20%"
 //           },
 //           "Predefined": false
 //       },
//
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ОпределитьСтавкуНДСПоСправочникуЕРП(УзелСправочника) Экспорт
	
	СтавкаНДС = УзелСправочника.ПеречислениеСтавкаНДС.Значение;//строка
	
	Если СтавкаНДС = "НДС18" Тогда
		Возврат Перечисления.СтавкиНДС.НДС18;
	ИначеЕсли СтавкаНДС = "НДС18_118" Тогда
		Возврат Перечисления.СтавкиНДС.НДС18_118;
	ИначеЕсли СтавкаНДС = "НДС10" Тогда
		Возврат Перечисления.СтавкиНДС.НДС10;
	ИначеЕсли СтавкаНДС = "НДС10_110" Тогда
		Возврат Перечисления.СтавкиНДС.НДС10_110;
	ИначеЕсли СтавкаНДС = "НДС0" Тогда
		Возврат Перечисления.СтавкиНДС.НДС0;
	ИначеЕсли СтавкаНДС = "БезНДС" Тогда
		Возврат Перечисления.СтавкиНДС.БезНДС;
	ИначеЕсли СтавкаНДС = "НДС20" Тогда
		Возврат Перечисления.СтавкиНДС.НДС20;
	ИначеЕсли СтавкаНДС = "НДС20_120" Тогда
		Возврат Перечисления.СтавкиНДС.НДС20_120;
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции



// Поиск внешнего перечисления в спр ксп_КлассификаторПеречислений
//
// Параметры:
//	ВнешняяСистема		- Строка - например, "ЕРП"
//	Объект				- Строка - например, "Справочник.НаборыУпаковок"
//	Значение 			- Строка - например, "БазовыеЕдиницыИзмерения", для справочника - имя предопределенного элемента
//									для перечисления - имя значения
//
// Возвращаемое значение:
//	Тип: Спр ссылка ксп_КлассификаторПеречислений
//
Функция НайтиПеречисление(ВнешняяСистема, Объект, Значение) Экспорт
		
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ксп_КлассификаторПеречислений.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.ксп_КлассификаторПеречислений КАК ксп_КлассификаторПеречислений
		|ГДЕ
		|	ксп_КлассификаторПеречислений.КодВнешнейСистемы = &КодВнешнейСистемы
		|	И ксп_КлассификаторПеречислений.ОбъектИсточник = &ОбъектИсточник
		|	И ксп_КлассификаторПеречислений.Значение = &Значение";
		
	
	Запрос.УстановитьПараметр("Значение", Значение);
	
	Запрос.УстановитьПараметр("КодВнешнейСистемы", ВнешняяСистема);
	Запрос.УстановитьПараметр("ОбъектИсточник", Объект);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Возврат ВыборкаДетальныеЗаписи.Ссылка;
	КонецЦикла;
	
	
	Возврат Неопределено;
	
КонецФункции


// алгоритм взят из КД2
//		
		// принципы импорта единиц измерения:
		//
		// Если в ЕРП Владелец элемента спр "УпаковкиЕдиницыИзмерения":
		//	* Справочники.НаборыУпаковок.БазовыеЕдиницыИзмерения 
		//	или
		//	* не указан
		// То это Базовая Единица
		// Ищем эту Единицу в Рознице в спр "БазовыеЕдиницыИзмерения" по Наименование
		//
		// Пример тэга из ЕРП:
		//
		//"ЕдиницаИзмерения": {
		//    "type": "Справочник.УпаковкиЕдиницыИзмерения",
		//    "Ref": "4d3d3ed8-eda6-11ed-8b9e-04ed33c124eb",
		//    "isFolder": false,
		//    "Parent": {
		//        "type": "Справочник.УпаковкиЕдиницыИзмерения"
		//    },
		//    "Code": "796 ",
		//    "Owner": {
		//        "type": "Справочник.НаборыУпаковок",
		//        "Ref": "c91bef45-eda5-11ed-8b9e-04ed33c124eb",
		//        "isFolder": false,
		//        "Code": ""
		//    }
		//},		
//		
		// Если же в ЕРП владельцем спр "УпаковкиЕдиницыИзмерения" является спр Номенклатура,
		// то ищем в Рознице в спр "УпаковкиНоменклатуры" по:
		// * Владелец
		// * ЕдиницаИзмерения - спр ссылка  "БазовыеЕдиницыИзмерения"
		//
//
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиЕдиницуИзмерения(УзелЕдиницы, УзелНоменклатуры = Неопределено) Экспорт
	
	Наименование = "";
	УзелЕдиницы.Свойство("Наименование", Наименование);
	Если НЕ ЗначениеЗаполнено(Наименование) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Владелец = "";
	УзелЕдиницы.Свойство("Owner", Владелец);
	
	Если (НЕ ЗначениеЗаполнено(Владелец)) 
		ИЛИ
		(Владелец.type = "Справочник.НаборыУпаковок"
		И
		Владелец.Predefined = true
		И
		Владелец.PredefinedName = "БазовыеЕдиницыИзмерения")
		Тогда
		Возврат Справочники.БазовыеЕдиницыИзмерения.НайтиПоНаименованию(УзелЕдиницы.Наименование, Истина);
	КонецЕсли;
		
	Если ЗначениеЗаполнено(Владелец) И Владелец.type = "Справочник.Номенклатура" Тогда
		
		Если ЗначениеЗаполнено(УзелНоменклатуры) Тогда
			Запрос = Новый Запрос;
			Запрос.Текст = 
				"ВЫБРАТЬ
				|	УпаковкиНоменклатуры.Ссылка КАК Ссылка
				|ИЗ
				|	Справочник.УпаковкиНоменклатуры КАК УпаковкиНоменклатуры
				|ГДЕ
				|	УпаковкиНоменклатуры.Наименование = &Наименование
				|	И УпаковкиНоменклатуры.Владелец = &Владелец";
			
			//через имя общ модуля, чтобы ПИ работало
			Владелец = ксп_ИмпортСлужебный.НайтиНоменклатуру(УзелНоменклатуры);
			
			Запрос.УстановитьПараметр("Владелец", Владелец);
			
			РезультатЗапроса = Запрос.Выполнить();
			
			ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
			
			Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
				Возврат ВыборкаДетальныеЗаписи.Ссылка;
			КонецЦикла;
		КонецЕсли;	
		
	КонецЕсли;
	
		
	Возврат Неопределено;
	
КонецФункции


// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиНоменклатуру(УзелНоменклатуры) Экспорт
	
	НоменклатураГУИД = "";
	Если УзелНоменклатуры.Свойство("Ref", НоменклатураГУИД) Тогда
		Возврат Справочники.Номенклатура.ПолучитьСсылку(Новый УникальныйИдентификатор(НоменклатураГУИД));
	КонецЕсли;
		
	Возврат Неопределено;
	
КонецФункции

Функция НайтиХарактеристику(УзелХарактеристики) Экспорт
	
	ХарактеристикаГУИД = "";
	Если УзелХарактеристики.Свойство("Ref", ХарактеристикаГУИД) Тогда
		Возврат Справочники.ХарактеристикиНоменклатуры.ПолучитьСсылку(Новый УникальныйИдентификатор(ХарактеристикаГУИД));
	КонецЕсли;
		
	Возврат Неопределено;
	
КонецФункции

Функция НайтиОрганизацию(Узел) Экспорт
	
	Организация = Неопределено;
	гуид = "";
	Если узел.Свойство("Ref", гуид) Тогда
		Организация = РегистрыСведений.ксп_МэппингСправочникОрганизации.ПоМэппингу(гуид);
		Если НЕ ЗначениеЗаполнено(Организация) ИЛИ НЕ ЗначениеЗаполнено(Организация.ВерсияДанных) Тогда
			Организация = Справочники.Организации.ПолучитьСсылку(Новый УникальныйИдентификатор(гуид));
		КонецЕсли;
	КонецЕсли;
		
	Возврат Организация;
	
КонецФункции

// Поиск контрагента по приоритетам:
// 1. сначала мэппинг
// 2. затем ГУИД
Функция НайтиКонтрагента(Узел, ВнешняяСистема) Экспорт

	Контрагент = Неопределено;
	ГУИД = "";
	Если узел.Свойство("Ref", ГУИД) Тогда
		Контрагент = РегистрыСведений.ксп_МэппингСправочникКонтрагенты.ПоМэппингу(ГУИД, ВнешняяСистема);
		Если НЕ ЗначениеЗаполнено(Контрагент) ИЛИ НЕ ЗначениеЗаполнено(Контрагент.ВерсияДанных) Тогда
			Контрагент = Справочники.Контрагенты.ПолучитьСсылку(Новый УникальныйИдентификатор(ГУИД));
		КонецЕсли;
	КонецЕсли;
	Возврат Контрагент;
	
КонецФункции
