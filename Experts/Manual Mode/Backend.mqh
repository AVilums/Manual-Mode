#include <Math\Stat\Stat.mqh>
#include <EasyAndFastGUI\WndCreate.mqh>
#include <EasyAndFastGUI\TimeCounter.mqh>

class CBackend : public CWndCreate {
   protected:
      CWindow m_window;

      CStatusBar m_status_bar;

      CTextEdit base;
      CTextEdit extreme;
      CTextEdit target;
      CTextEdit volume;
      
      CTextLabel rr;
      CTextLabel percentage;  
      CTextLabel cash;
      CTextLabel pip_value;

      CComboBox zone_type;
      CComboBox range_type;
      CComboBox entry_method;

      CButton add;
      CButton refresh;

   protected:

      void RiskToReward();
      void CashRisk();

      void UpdateCalcField();

   public:
      CBackend(void);
      ~CBackend(void);

      void OnInitEvent(void);
      void OnDeinitEvent(const int reason);
      void OnTimerEvent(void);
      
      double GetBase() { return StringToDouble(base.GetValue());}
      double GetExtreme() { return StringToDouble(extreme.GetValue());}
      double GetTarget() { return StringToDouble(target.GetValue());}
      double GetVolume() { return StringToDouble(volume.GetValue());}

      virtual void OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);

      bool CreateGUI(void);
};

#include "EntryMethods.mqh"
#include "Calculations.mqh"
#include "MainWindow.mqh"
// #include <Trade/Trade.mqh>
// CTrade *trade = new CTrade;

CBackend::CBackend(void) {}
CBackend::~CBackend(void) {}

void CBackend::OnInitEvent(void) { }

void CBackend::OnDeinitEvent(const int reason) { 
   CWndEvents::Destroy();
   delete_trade_obj();
}

void CBackend::OnTimerEvent(void) { }

void CBackend::UpdateCalcField() {
   RiskToReward();

   pip_value.LabelText("Pip Value: " + DoubleToString(get_pip_value(GetVolume()), 4));
   pip_value.Update(true); 

   CashRisk();

   percentage.LabelText("Risk %: " + precentage_risk(GetBase(),GetExtreme(), GetVolume(), entry_method.GetValue()));
   percentage.Update(true);
}

void CBackend::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam) {   

   if (id == CHARTEVENT_CUSTOM + ON_CLICK_BUTTON) {
      UpdateCalcField();

      if (lparam == add.Id()) {
         double cbase = StringToDouble(base.GetValue());
         double cextreme = StringToDouble(extreme.GetValue());
         double ctarget = StringToDouble(target.GetValue());
         double cvolume = StringToDouble(volume.GetValue());

         if (entry_method.GetValue() == "EM1 (50%)") {
            entry_method1(GetBase(), GetExtreme(), GetTarget(), GetVolume(),
            zone_type.GetValue());

         } else if (entry_method.GetValue() == "EM2 (base & 50%)") {
            entry_method2(GetBase(), GetExtreme(), GetTarget(), GetVolume(),
            zone_type.GetValue(), range_type.GetValue());
         }
      }
      return;
   }
}

void CBackend::RiskToReward() {
   double value = risk_to_reward(GetBase(),GetExtreme(),GetTarget(), 
                                    entry_method.GetValue(), zone_type.GetValue());

   string text = DoubleToString(value, 2);
   
   rr.LabelText("Risk-to-reward: " + text);
   rr.Update(true);
}

void CBackend::CashRisk() {
   double value = cash_risk(GetBase(),GetExtreme(), GetVolume(), 
                              entry_method.GetValue(), zone_type.GetValue());

   string text = DoubleToString(value, 2);

   cash.LabelText("Risk €: " + text);
   cash.Update(true);
}

