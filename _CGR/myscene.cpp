#include "manager.hpp"
#include "ecs.hpp"
#include "geometry/geometryindexedbase.hpp"
#include "geometry/simplesphere.hpp"
#include "transformation/transformation.hpp"
#include "transformation/keyboardtransformationcontroller.hpp"
#include "transformation/relationship.hpp"
#include "rendering/renderable.hpp"
#include "rendering/openglstates.hpp"
#include "rendering/color.hpp"

void Manager::initialize()
{
    const float lMoonSpeed = 7.0, lSunSpeed = lMoonSpeed / 12.0f, lEarthSpeed = lMoonSpeed * 28.0f;


    /** Sun */
    auto lSun = addRenderable<GeometryIndexedBase, SimpleSphere>(SimpleSphere(5.f));
    auto &lTrans = ECS.get<Transformation>(lSun);
    auto lSunKeyTrans = addController<KeyboardTransformationController>(lSun);

    //rotation
    lSunKeyTrans->setRotKeys(KeyboardTransformationController::NoKey, KeyboardTransformationController::NoKey, 'r', 'R',
                          KeyboardTransformationController::NoKey, KeyboardTransformationController::NoKey);
    lSunKeyTrans->setRotspeed(lSunSpeed);

    //visual properties
    auto lSunFilled = std::make_shared<OpenGLStates>();
    lSunFilled->setFilled(false);

    auto lSunColor = std::make_shared<Color>(1.0f, 1.0f, 0.0f, 1.0f);
    ECS.get<Renderable>(lSun).addProperty(lSunFilled);
    ECS.get<Renderable>(lSun).addProperty(lSunColor);


    /** Earth */
    auto lEarth = addRenderable<GeometryIndexedBase, SimpleSphere>(SimpleSphere(0.8f));
    auto& lEarthOrbit = addTransformationEntity();
    auto lEarthKeyTrans = addController<KeyboardTransformationController>(lEarth);
    Relationship::addChild(lSun, entt::to_entity(ECS, lEarthOrbit));
    Relationship::addChild(entt::to_entity(ECS, lEarthOrbit), lEarth);

    //position
    auto& transEarth = ECS.get<Transformation>(lEarth);
    transEarth.translate(8.f, 0.f, 0.f);

    //rotation
    lEarthKeyTrans->setRotKeys(KeyboardTransformationController::NoKey, KeyboardTransformationController::NoKey, 'r', 'R',
                          KeyboardTransformationController::NoKey, KeyboardTransformationController::NoKey);
    lEarthKeyTrans->setRotspeed(lEarthSpeed);

    //visual properties
    auto lEarthFilled = std::make_shared<OpenGLStates>();
    lEarthFilled->setFilled(false);

    auto lEarthColor = std::make_shared<Color>(0.0f, 0.0f, 1.0f, 1.0f);
    ECS.get<Renderable>(lEarth).addProperty(lEarthFilled);
    ECS.get<Renderable>(lEarth).addProperty(lEarthColor);


    /** Moon */
    auto lMoon = addRenderable<GeometryIndexedBase, SimpleSphere>(SimpleSphere(0.1f));
    auto& lMoonOrbit = addTransformationEntity();
    Relationship::addChild(lEarth, entt::to_entity(ECS, lMoonOrbit));
    Relationship::addChild(entt::to_entity(ECS, lMoonOrbit), lMoon);

    //position
    auto& transMoon = ECS.get<Transformation>(lMoon);
    transMoon.translate(0.f, 0.f, 2.f);

    //visual properties
    auto lMoonFilled = std::make_shared<OpenGLStates>();
    lMoonFilled->setFilled(false);

    auto lMoonColor = std::make_shared<Color>(0.5f, 0.5f, 0.5f, 1.0f);
    ECS.get<Renderable>(lMoon).addProperty(lMoonFilled);
    ECS.get<Renderable>(lMoon).addProperty(lMoonColor);



}
