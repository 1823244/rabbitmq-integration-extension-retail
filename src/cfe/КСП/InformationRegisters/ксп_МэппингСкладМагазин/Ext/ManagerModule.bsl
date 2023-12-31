﻿
// Описание_метода
//
// Параметры:
//	Склад 	- структура (из json) / СправочникСсылка.Склады - 
//
// Возвращаемое значение:
//	Тип: СправочникСсылка.Магазины
//
Функция ПоМэппингу(Склад, ВнешняяСистема) Экспорт

	Перем _Склад;
	
	Если ТипЗнч(Склад) = Тип("Структура") Тогда   // это узел json
		_Склад = ксп_ИмпортСлужебный.НайтиСклад(Склад, ВнешняяСистема);	
	Иначе 
		_Склад = Склад;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ксп_МэппингСкладМагазин.Магазин КАК Магазин
		|ИЗ
		|	РегистрСведений.ксп_МэппингСкладМагазин КАК ксп_МэппингСкладМагазин
		|ГДЕ
		|	ксп_МэппингСкладМагазин.Склад = &Склад
		|	И ксп_МэппингСкладМагазин.ВнешняяСистема = &ВнешняяСистема";
	
	Запрос.УстановитьПараметр("Склад", _Склад);
	Запрос.УстановитьПараметр("ВнешняяСистема", ВнешняяСистема);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Возврат ВыборкаДетальныеЗаписи.Магазин;
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции
