#include "Backend.mqh"

bool CBackend::CreateGUI(void) {

   if(!CWndCreate::CreateWindow(m_window,"MANUAL MODE",1,1,300,400,true,false,true,false))
      return(false);

   string text_items[2];
   text_items[0]="For Traders, By Traders";
   text_items[1]="Keep at it...";
   int width_items[]={0,130};
   if(!CWndCreate::CreateStatusBar(m_status_bar,m_window,1,23,22,text_items,width_items))
      return(false);

   if(!CWndCreate::CreateTextEdit(base,"Base:",m_window,0,false,7,25,125,70,100000,1,0.001,3,SymbolInfoDouble(Symbol(), SYMBOL_ASK)))
      return(false);

   if(!CWndCreate::CreateTextEdit(extreme,"Extreme:",m_window,0,false,7,50,125,70,100000,1,0.001,3,SymbolInfoDouble(Symbol(), SYMBOL_ASK)))
      return(false);

   if(!CWndCreate::CreateTextEdit(target,"Target:",m_window,0,false,7,75,125,70,100000,1,0.001,3,SymbolInfoDouble(Symbol(), SYMBOL_ASK)))
      return(false);

   if(!CWndCreate::CreateTextEdit(volume,"Volume:",m_window,0,false,150,25,125,70,100000,0.01,0.01,2,0.01))
      return(false);   

   if(!CWndCreate::CreateTextEdit(cash,"Cash:",m_window,0,false,150,50,125,70,100000000,0.00,0.01,2,0.00))
      return(false);

   if(!CWndCreate::CreateTextEdit(percentage,"%",m_window,0,false,150,75,125,70,100,0.00,0.01,2,0.00))
      return(false);

   string items1[]={"SZ", "BZ"};
   if(!CWndCreate::CreateCombobox(zone_type,"Zone type:",m_window,0,false,7,100,215,130,items1,40,0))
      return(false);

   string items2[]= { "BODY","WICK"};
   if(!CWndCreate::CreateCombobox(range_type,"Range type:",m_window,0,false,7,125,215,130,items2,40,0))
      return(false);

   string items3[]= { "EM1 (50%)","EM2 (base & 50%)"};
   if(!CWndCreate::CreateCombobox(entry_method,"Entry method:",m_window,0,false,7,150,215,130,items3,40,0))
      return(false);

   if(!CWndCreate::CreateButton(add,"Add",m_window,0,7,250,100))
      return(false);

   CWndEvents::CompletedGUI();
      return(true);
}
