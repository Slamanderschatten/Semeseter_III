#ifndef ARM_HPP
#define ARM_HPP

#include "bodypart.hpp"
#include "manager.hpp"
#include "transformation/keyboardtransformationcontroller.hpp"
#include "transformation/relationship.hpp"
#include "QtMath"

class ArmController: public KeyboardTransformationController {

public:
    ArmController(entt::entity pEnt): KeyboardTransformationController(pEnt) {}
    //! Callback zum Auswerten des Inputs
    virtual void doControl() override {

        Q_ASSERT(ECS.all_of<Transformation>(mEntity));
        auto &lTrans = ECS.get<Transformation>(mEntity);

        auto lKeyIn = InputRegistry::getInstance().getKeyboardInput();
        if(lKeyIn->isKeyPressed('i') || lKeyIn->isKeyPressed('k')) {
            lTrans.rotate(mRotSpeed, 1.0, 0.0, 0.0);
        }

        mProgress += abs(mRotSpeed);
        if(mProgress > 45) {
            setRotspeed(-getRotSpeed());
            mProgress = 0;
        }
    }

protected:
    float mProgress{22.5f};
};

class Arm: public BodyPart {
private:
    BodyPart arm = BodyPart(1.f, 6.f, 1.f, .5f, .5f, 1.f);
    BodyPart hand = BodyPart(.2f, 0.5f, .2f, 1.f, .5f, .5f);


public:

    Arm(float pWidth, float pHeight, float pDepth, char pChar, bool pRightArm = false): BodyPart(pWidth, pHeight, pDepth) {


        Relationship::addChild(getTrafoEnt(), arm.getTrafoEnt());
        Relationship::addChild(arm.getTrafoEnt(), hand.getTrafoEnt());

        float distX = arm.getSize().x() / 2;
        if(pRightArm)
            distX = -distX;

        arm.setPosition(distX, -arm.getSize().y() / 2 + arm.getSize().z() / 2, 0.f);
        hand.setPosition(0.f, -(arm.getSize().y() / 2 + hand.getSize().y() / 2), 0.f);

    }
    Arm(float pWidth, float pHeight, float pDepth, float pRed, float pGreen, float pBlue, char pChar, bool pRightArm = false):
        Arm(pWidth, pHeight, pDepth, pChar, pRightArm) {
        setColor(pRed, pGreen, pBlue);
    }

};

#endif // ARM_HPP
