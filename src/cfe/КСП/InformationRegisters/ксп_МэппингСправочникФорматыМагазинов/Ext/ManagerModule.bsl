﻿
// Описание_метода
//
// Параметры:
//	GUID 	- строка - 36 символов, ГУИД
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ПоМэппингу(GUID, ВнешняяСистема) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	Рег.ФорматМагазина КАК ФорматМагазина
		|ИЗ
		|	РегистрСведений.ксп_МэппингСправочникФорматыМагазинов КАК Рег
		|ГДЕ
		|	Рег.GUID = &GUID
		|	И Рег.ВнешняяСистема = &ВнешняяСистема";
	
	Запрос.УстановитьПараметр("GUID", GUID);
	Запрос.УстановитьПараметр("ВнешняяСистема", ВнешняяСистема);
	
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Возврат ВыборкаДетальныеЗаписи.ФорматМагазина;
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции

// Описание_метода
Функция ЕстьГУИД(GUID, ВнешняяСистема) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ 1
		|ИЗ
		|	РегистрСведений.ксп_МэппингСправочникФорматыМагазинов КАК Рег
		|ГДЕ
		|	Рег.GUID = &GUID
		|	И Рег.ВнешняяСистема = &ВнешняяСистема";
	
	Запрос.УстановитьПараметр("GUID", GUID);
	Запрос.УстановитьПараметр("ВнешняяСистема", ВнешняяСистема);
	
	РезультатЗапроса = Запрос.Выполнить(); 
	
	Возврат НЕ РезультатЗапроса.Пустой();
		
КонецФункции

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
Процедура ДобавитьГУИД(GUID, Наименование, ВнешняяСистема) Экспорт
	
	НЗ = РегистрыСведений.ксп_МэппингСправочникФорматыМагазинов.СоздатьНаборЗаписей();
	НЗ.Отбор.GUID.Установить(GUID);
	НЗ.Отбор.ВнешняяСистема.Установить(ВнешняяСистема);
	стрк = НЗ.Добавить();
	стрк.GUID = GUID;
	стрк.Наименование = Наименование;  
	стрк.ВнешняяСистема = ВнешняяСистема;	
	НЗ.Записать();
		
КонецПроцедуры

// Описание_метода
Процедура ДобавитьЗапись(GUID, Наименование, ВнешняяСистема, ФорматМагазина) Экспорт
	
	НЗ = РегистрыСведений.ксп_МэппингСправочникФорматыМагазинов.СоздатьНаборЗаписей();
	НЗ.Отбор.GUID.Установить(GUID);
	НЗ.Отбор.ВнешняяСистема.Установить(ВнешняяСистема);
	стрк = НЗ.Добавить();
	стрк.GUID = GUID;
	стрк.Наименование = Наименование;  
	стрк.ВнешняяСистема = ВнешняяСистема;	
	стрк.ФорматМагазина = ФорматМагазина;	
	НЗ.Записать();
		
КонецПроцедуры
