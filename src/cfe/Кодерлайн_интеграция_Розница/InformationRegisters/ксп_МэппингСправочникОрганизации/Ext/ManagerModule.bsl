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
		Возврат ВыборкаДетальныеЗаписи.Ссылка;
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции
