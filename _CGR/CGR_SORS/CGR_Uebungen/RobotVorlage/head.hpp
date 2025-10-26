#ifndef HEAD_HPP
#define HEAD_HPP

#include "bodypart.hpp"
#include "manager.hpp"
#include "transformation/keyboardtransformationcontroller.hpp"

class HeadController: public KeyboardTransformationController {

public:
    HeadController(entt::entity pEnt): KeyboardTransformationController(pEnt) {}
    //! Callback zum Auswerten des Inputs
    virtual void doControl() override {

        Q_ASSERT(ECS.all_of<Transformation>(mEntity));
        auto &lTrans = ECS.get<Transformation>(mEntity);

        auto lKeyIn = InputRegistry::getInstance().getKeyboardInput();
        if(lKeyIn->isKeyPressed('i') || lKeyIn->isKeyPressed('k')) {
            lTrans.rotate(mRotSpeed, 0.0, 1.0, 0.0);
        }

        mProgress += abs(mRotSpeed);
        if(mProgress > 10) {
            setRotspeed(-getRotSpeed());
            mProgress = 0;
        }
    }
    float mProgress{5.0f};

protected:
    float mSize{0.f};
};

class Head: public BodyPart {
public:
    Head(float pWidth, float pHeight, float pDepth, char pChar): BodyPart(pWidth, pHeight, pDepth) {
//Hier Rotkeys belegen und Größe richtig setzen
    }
    Head(float pWidth, float pHeight, float pDepth, float pRed, float pGreen, float pBlue, char pChar):
            Head(pWidth, pHeight, pDepth, pChar) {
        setColor(pRed, pGreen, pBlue);
    }

};

#endif // HEAD_HPP
