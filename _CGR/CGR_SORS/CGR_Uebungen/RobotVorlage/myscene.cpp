#include "arm.hpp"
#include "head.hpp"
#include "transformation/keyboardtransformationcontroller.hpp"
#include "transformation/relationship.hpp"
#include "manager.hpp"
#include "ecs.hpp"
#include "bodypart.hpp"

void Manager::initialize()
{
    const float walkSpeed = 0.2f;
    const float armSpeed = 4.f;
    const float headSpeed = 0.5f;
    const auto noKey = KeyboardTransformationController::NoKey;

    auto lTorso = BodyPart(4.f, 8.f, 4.f, 1.f, 0.f, 0.f);
    auto lTorsoCtrl = addController<KeyboardTransformationController>(lTorso.getTrafoEnt());
    //arm left
    auto lArmLeft = Arm(0.f,0.f,0.f, 'l', false);
    auto lArmLeftCtrl = addController<ArmController>(lArmLeft.getTrafoEnt());
    //arm right
    auto lArmRight = Arm(0.f,0.f,0.f, 'r', true);
    auto lArmRightCtrl = addController<ArmController>(lArmRight.getTrafoEnt());
    //head
    auto lHead = Head(2.f, 1.f, 2.f, 1.f, 1.f, 0.f, 't');
    auto lHeadCtrl = addController<HeadController>(lHead.getTrafoEnt());
    //legs
    auto lLegs = BodyPart(1.5f, 1.5f, 1.5f, 0.f, 0.f, 1.f);
    auto lFeet = BodyPart(3.0f, 0.3f, 3.0f, 0.f, 1.f, 0.f);


    ////torso


    ////arms
    float armPosX = lTorso.getSize().x() / 2;
    float armPosY = lTorso.getSize().y() / 16 * 7;
    Relationship::addChild(lTorso.getTrafoEnt(), lArmLeft.getTrafoEnt());
    lArmLeft.setPosition(armPosX, armPosY, .0f);
    Relationship::addChild(lTorso.getTrafoEnt(), lArmRight.getTrafoEnt());
    lArmRight.setPosition(-armPosX, armPosY, .0f);


    ////head
    Relationship::addChild(lTorso.getTrafoEnt(), lHead.getTrafoEnt());
    lHead.setPosition(0.f, lTorso.getSize().y()/2 + lHead.getSize().y()/2, 0.f);

    ////legs
    Relationship::addChild(lTorso.getTrafoEnt(), lLegs.getTrafoEnt());
    lLegs.setPosition(0.f, -(lTorso.getSize().y()/2 + lLegs.getSize().y()/2), 0.f);
    Relationship::addChild(lLegs.getTrafoEnt(), lFeet.getTrafoEnt());
    lFeet.setPosition(0.f, -(lLegs.getSize().y()/2 + lFeet.getSize().y()/2), 0.f);



    ////controller
    lTorsoCtrl->setTransspeed(walkSpeed);
    lTorsoCtrl->setTransKeys('l', 'j', noKey, noKey, 'k', 'i');

    lArmLeftCtrl->setRotspeed(armSpeed);
    lArmLeftCtrl->setRotKeys('k', 'i', noKey, noKey, noKey, noKey);
    lArmRightCtrl->setRotspeed(-armSpeed);
    lArmRightCtrl->setRotKeys('k', 'i', noKey, noKey, noKey, noKey);

    lHeadCtrl->setRotspeed(headSpeed);
    lHeadCtrl->setRotKeys(noKey, noKey, 'k', 'i', noKey, noKey);

}
