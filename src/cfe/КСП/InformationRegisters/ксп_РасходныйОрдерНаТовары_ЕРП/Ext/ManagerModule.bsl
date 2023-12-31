﻿
// Возвращает данные одного документа в структуре: шапка + табл части
//
// Параметры:
//	мВнешняяСистема 	- строка - 
//	РасходныйОрдерГУИД 	- строка - 
//
// Возвращаемое значение:
//	Тип: структура
//
Функция ДанныеДокумента(ВнешняяСистема, РасходныйОрдерГУИД) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ксп_РасходныйОрдерНаТовары_ЕРП.ГУИД КАК ГУИД,
		|	ксп_РасходныйОрдерНаТовары_ЕРП.ВнешняяСистема КАК ВнешняяСистема,
		|	ксп_РасходныйОрдерНаТовары_ЕРП.ДатаДокумента КАК ДатаДокумента,
		|	ксп_РасходныйОрдерНаТовары_ЕРП.НомерДокумента КАК НомерДокумента,
		|	ксп_РасходныйОрдерНаТовары_ЕРП.Проведен КАК Проведен,
		|	ксп_РасходныйОрдерНаТовары_ЕРП.ПометкаУдаления КАК ПометкаУдаления,
		|	ксп_РасходныйОрдерНаТовары_ЕРП.ВсегоМест КАК ВсегоМест,
		|	ксп_РасходныйОрдерНаТовары_ЕРП.ДатаОтгрузки КАК ДатаОтгрузки,
		|	ксп_РасходныйОрдерНаТовары_ЕРП.ЗаданиеНаПеревозку КАК ЗаданиеНаПеревозку,
		|	ксп_РасходныйОрдерНаТовары_ЕРП.ЗонаОтгрузки КАК ЗонаОтгрузки,
		|	ксп_РасходныйОрдерНаТовары_ЕРП.Комментарий КАК Комментарий,
		|	ксп_РасходныйОрдерНаТовары_ЕРП.Контролер КАК Контролер,
		|	ксп_РасходныйОрдерНаТовары_ЕРП.Ответственный КАК Ответственный,
		|	ксп_РасходныйОрдерНаТовары_ЕРП.ОтгрузкаПоЗаданиюНаПеревозку КАК ОтгрузкаПоЗаданиюНаПеревозку,
		|	ксп_РасходныйОрдерНаТовары_ЕРП.Получатель КАК Получатель,
		|	ксп_РасходныйОрдерНаТовары_ЕРП.Помещение КАК Помещение,
		|	ксп_РасходныйОрдерНаТовары_ЕРП.ПорядокДоставки КАК ПорядокДоставки,
		|	ксп_РасходныйОрдерНаТовары_ЕРП.Приоритет КАК Приоритет,
		|	ксп_РасходныйОрдерНаТовары_ЕРП.РежимПросмотраПоТоварам КАК РежимПросмотраПоТоварам,
		|	ксп_РасходныйОрдерНаТовары_ЕРП.Склад КАК Склад,
		|	ксп_РасходныйОрдерНаТовары_ЕРП.СкладскаяОперация КАК СкладскаяОперация,
		|	ксп_РасходныйОрдерНаТовары_ЕРП.Статус КАК Статус
		|ИЗ
		|	РегистрСведений.ксп_РасходныйОрдерНаТовары_ЕРП КАК ксп_РасходныйОрдерНаТовары_ЕРП
		|ГДЕ
		|	ксп_РасходныйОрдерНаТовары_ЕРП.ГУИД = &ГУИД
		|	И ксп_РасходныйОрдерНаТовары_ЕРП.ВнешняяСистема = &ВнешняяСистема";
	
	Запрос.УстановитьПараметр("ВнешняяСистема", ВнешняяСистема);
	Запрос.УстановитьПараметр("ГУИД", РасходныйОрдерГУИД);
	
	РезультатЗапроса = Запрос.Выполнить();
	ТЗ = РезультатЗапроса.Выгрузить();
	
	РезСтруктура = Новый Структура;
	
	Для каждого стрк Из ТЗ Цикл
		Для каждого кол_ Из ТЗ.Колонки Цикл
			РезСтруктура.Вставить(кол_.Имя, стрк[кол_.Имя]);	
		КонецЦикла;	
	КонецЦикла;
	
	
	// ТЧ: ТоварыПоРаспоряжениям

	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ксп_РасходныйОрдерНаТовары_ЕРП_ТоварыПоРаспоряжениям.ГУИД КАК ГУИД,
		|	ксп_РасходныйОрдерНаТовары_ЕРП_ТоварыПоРаспоряжениям._НомерСтроки КАК _НомерСтроки,
		|	ксп_РасходныйОрдерНаТовары_ЕРП_ТоварыПоРаспоряжениям.ВнешняяСистема КАК ВнешняяСистема,
		|	ксп_РасходныйОрдерНаТовары_ЕРП_ТоварыПоРаспоряжениям.Номенклатура КАК Номенклатура,
		|	ксп_РасходныйОрдерНаТовары_ЕРП_ТоварыПоРаспоряжениям.Характеристика КАК Характеристика,
		|	ксп_РасходныйОрдерНаТовары_ЕРП_ТоварыПоРаспоряжениям.Назначение КАК Назначение,
		|	ксп_РасходныйОрдерНаТовары_ЕРП_ТоварыПоРаспоряжениям.Серия КАК Серия,
		|	ксп_РасходныйОрдерНаТовары_ЕРП_ТоварыПоРаспоряжениям.СтатусУказанияСерий КАК СтатусУказанияСерий,
		|	ксп_РасходныйОрдерНаТовары_ЕРП_ТоварыПоРаспоряжениям.Распоряжение КАК Распоряжение,
		|	ксп_РасходныйОрдерНаТовары_ЕРП_ТоварыПоРаспоряжениям.Количество КАК Количество
		|ИЗ
		|	РегистрСведений.ксп_РасходныйОрдерНаТовары_ЕРП_ТоварыПоРаспоряжениям КАК ксп_РасходныйОрдерНаТовары_ЕРП_ТоварыПоРаспоряжениям
		|ГДЕ
		|	ксп_РасходныйОрдерНаТовары_ЕРП_ТоварыПоРаспоряжениям.ГУИД = &ГУИД
		|	И ксп_РасходныйОрдерНаТовары_ЕРП_ТоварыПоРаспоряжениям.ВнешняяСистема = &ВнешняяСистема";
	
	Запрос.УстановитьПараметр("ВнешняяСистема", ВнешняяСистема);
	Запрос.УстановитьПараметр("ГУИД", РасходныйОрдерГУИД);
	
	
	РезультатЗапроса = Запрос.Выполнить();
	ТЗ = РезультатЗапроса.Выгрузить();
	
	МассивСтрок = Новый Массив;
	
	Для каждого стрк Из ТЗ Цикл
		СтруктураСтроки = Новый Структура;
		Для каждого кол_ Из ТЗ.Колонки Цикл
			СтруктураСтроки.Вставить(кол_.Имя, стрк[кол_.Имя]);	
		КонецЦикла;	
		МассивСтрок.Добавить(СтруктураСтроки);
	КонецЦикла;
	
	РезСтруктура.Вставить("ТоварыПоРаспоряжениям", МассивСтрок);
	
	
	
	
	// ТЧ: ОтгружаемыеТовары

	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ксп_РасходныйОрдерНаТовары_ЕРП_ОтгружаемыеТовары.ГУИД КАК ГУИД,
		|	ксп_РасходныйОрдерНаТовары_ЕРП_ОтгружаемыеТовары._НомерСтроки КАК _НомерСтроки,
		|	ксп_РасходныйОрдерНаТовары_ЕРП_ОтгружаемыеТовары.ВнешняяСистема КАК ВнешняяСистема,
		|	ксп_РасходныйОрдерНаТовары_ЕРП_ОтгружаемыеТовары.Номенклатура КАК Номенклатура,
		|	ксп_РасходныйОрдерНаТовары_ЕРП_ОтгружаемыеТовары.Характеристика КАК Характеристика,
		|	ксп_РасходныйОрдерНаТовары_ЕРП_ОтгружаемыеТовары.Назначение КАК Назначение,
		|	ксп_РасходныйОрдерНаТовары_ЕРП_ОтгружаемыеТовары.Серия КАК Серия,
		|	ксп_РасходныйОрдерНаТовары_ЕРП_ОтгружаемыеТовары.СтатусУказанияСерий КАК СтатусУказанияСерий,
		|	ксп_РасходныйОрдерНаТовары_ЕРП_ОтгружаемыеТовары.ЭтоУпаковочныйЛист КАК ЭтоУпаковочныйЛист,
		|	ксп_РасходныйОрдерНаТовары_ЕРП_ОтгружаемыеТовары.ЭтоСлужебнаяСтрокаПустогоУпаковочногоЛиста КАК ЭтоСлужебнаяСтрокаПустогоУпаковочногоЛиста,
		|	ксп_РасходныйОрдерНаТовары_ЕРП_ОтгружаемыеТовары.УпаковочныйЛистРодитель КАК УпаковочныйЛистРодитель,
		|	ксп_РасходныйОрдерНаТовары_ЕРП_ОтгружаемыеТовары.УпаковочныйЛист КАК УпаковочныйЛист,
		|	ксп_РасходныйОрдерНаТовары_ЕРП_ОтгружаемыеТовары.Упаковка КАК Упаковка,
		|	ксп_РасходныйОрдерНаТовары_ЕРП_ОтгружаемыеТовары.Количество КАК Количество,
		|	ксп_РасходныйОрдерНаТовары_ЕРП_ОтгружаемыеТовары.КоличествоУпаковок КАК КоличествоУпаковок,
		|	ксп_РасходныйОрдерНаТовары_ЕРП_ОтгружаемыеТовары.Действие КАК Действие
		|ИЗ
		|	РегистрСведений.ксп_РасходныйОрдерНаТовары_ЕРП_ОтгружаемыеТовары КАК ксп_РасходныйОрдерНаТовары_ЕРП_ОтгружаемыеТовары
		|ГДЕ
		|	ксп_РасходныйОрдерНаТовары_ЕРП_ОтгружаемыеТовары.ГУИД = &ГУИД
		|	И ксп_РасходныйОрдерНаТовары_ЕРП_ОтгружаемыеТовары.ВнешняяСистема = &ВнешняяСистема";
	
	Запрос.УстановитьПараметр("ВнешняяСистема", ВнешняяСистема);
	Запрос.УстановитьПараметр("ГУИД", РасходныйОрдерГУИД);
	
	
	РезультатЗапроса = Запрос.Выполнить();
	ТЗ = РезультатЗапроса.Выгрузить();
	
	МассивСтрок = Новый Массив;
	
	Для каждого стрк Из ТЗ Цикл
		СтруктураСтроки = Новый Структура;
		Для каждого кол_ Из ТЗ.Колонки Цикл
			СтруктураСтроки.Вставить(кол_.Имя, стрк[кол_.Имя]);	
		КонецЦикла;	
		МассивСтрок.Добавить(СтруктураСтроки);
	КонецЦикла;
	
	РезСтруктура.Вставить("ОтгружаемыеТовары", МассивСтрок);
	

	
	
	
	
	// ТЧ: ______
	
	Возврат РезСтруктура;
	
КонецФункции
