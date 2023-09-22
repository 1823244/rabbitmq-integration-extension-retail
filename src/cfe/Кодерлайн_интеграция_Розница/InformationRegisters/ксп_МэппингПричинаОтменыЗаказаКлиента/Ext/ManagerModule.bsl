﻿
// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ПоМэппингу(GUID) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	Рег.ПричинаОтмены КАК ПричинаОтмены
		|ИЗ
		|	РегистрСведений.ксп_МэппингПричинаОтменыЗаказаКлиента КАК Рег
		|ГДЕ
		|	Рег.GUID = &GUID";
	
	Если GUID = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	//это может быть тэг узла ссылки (identification)
	Если ТипЗнч(GUID)  = Тип("Структура") Тогда
		ГУИД = "";
		GUID.Свойство("Ref", ГУИД);
		GUID = ГУИД;
	КонецЕсли;
	Если НЕ ЗначениеЗаполнено(GUID) Тогда
		Возврат Неопределено;
	КонецЕсли;
	Запрос.УстановитьПараметр("GUID", GUID);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Возврат ВыборкаДетальныеЗаписи.ПричинаОтмены;
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции
