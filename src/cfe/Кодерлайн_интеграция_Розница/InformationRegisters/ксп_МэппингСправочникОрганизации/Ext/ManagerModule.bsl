﻿
// Описание_метода
//
// Параметры:
//	GUID 	- строка - 36 символов, ГУИД
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ПоМэппингу(GUID) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	Рег.Организация КАК Организация
		|ИЗ
		|	РегистрСведений.ксп_МэппингСправочникОрганизации КАК Рег
		|ГДЕ
		|	Рег.GUID = &GUID";
	
	Запрос.УстановитьПараметр("GUID", GUID);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Возврат ВыборкаДетальныеЗаписи.Организация;
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции




Функция ЕстьГУИД(GUID) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ 1
		|ИЗ
		|	РегистрСведений.ксп_МэппингСправочникОрганизации КАК Рег
		|ГДЕ
		|	Рег.GUID = &GUID";
	
	Запрос.УстановитьПараметр("GUID", GUID);
	
	РезультатЗапроса = Запрос.Выполнить(); 
	
	Возврат НЕ РезультатЗапроса.Пустой();
		
КонецФункции


// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
Процедура ДобавитьГУИД(GUID, Наименование) Экспорт
	
	НЗ = РегистрыСведений.ксп_МэппингСправочникОрганизации.СоздатьНаборЗаписей();
	НЗ.Отбор.GUID.Установить(GUID);
	стрк = НЗ.Добавить();
	стрк.GUID = GUID;
	стрк.Наименование = Наименование;
	НЗ.Записать();
		
КонецПроцедуры


