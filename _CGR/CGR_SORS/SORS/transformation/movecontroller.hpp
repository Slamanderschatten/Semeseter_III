#ifndef MOVECONTROLLER_H
#define MOVECONTROLLER_H

#include "win_oglbase/wantstick.hpp"

//! Basisklasse aller Klassen, die die Orientierung oder Position eines Entity verändern wollen.
//! Die Methode getTick() wird von extern aufgerufen, sodass immer auf Events (z.B. Maus oder Tastatur) reagiert werden kann.
class MoveController : public WantsTick
{
public:
    MoveController(): WantsTick() {}
    float getMoveSpeed() const {return mMoveSpeed;};
    void setMoveSpeed(float moveSpeed) {mMoveSpeed = moveSpeed;};
    float getRotSpeed() const {return mRotSpeed;};
    void setRotSpeed(float rotSpeed) {mRotSpeed = rotSpeed;};

    void getTick() override {doControl();}

protected:
    float mMoveSpeed{1.f};
    float mRotSpeed{1.f};

    //! Diese Methode müssen abgeleitete Klassen implementieren und auf Events reagieren (z.B. abhängig von
    //! gedrückten Tasten eine Translation ausführen o.ä.)
    virtual void doControl() = 0;
};

#endif // MOVECONTROLLER_H
