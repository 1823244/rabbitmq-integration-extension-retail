﻿

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
Процедура ЗафиксироватьСозданиеПеремещения(
		ВнешняяСистема, 
		ЗаказНаПеремещениеГУИД, 
		РасходныйОрдерГУИД, 
		ПеремещениеТоваровСсылка) Экспорт
		
		
	Мен_ = РегистрыСведений.ксп_ИсточникДанныхДляПеремещенийТоваровИзЕРП.СоздатьМенеджерЗаписи();
	Мен_.ВнешняяСистема = ВнешняяСистема;
	Мен_.ЗаказНаПеремещениеГУИД = ЗаказНаПеремещениеГУИД;
	Мен_.РасходныйОрдерГУИД = РасходныйОрдерГУИД;
	Мен_.Прочитать();
	Если Мен_.Выбран() Тогда
		Мен_.ПеремещениеТоваровРозница = ПеремещениеТоваровСсылка;
		Мен_.ДатаСозданияПеремещения = ТекущаяДатаСеанса();
		Мен_.Записать();
	КонецЕсли;
		
КонецПроцедуры
