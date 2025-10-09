#include "manager.hpp"
#include "ecs.hpp"
#include "rendering/openglstates.hpp"
#include "shadermanager.hpp"
#include "transformation/keyboardtransformationcontroller.hpp"
#include "geometry/tessplane.hpp"

void Manager::initialize()
{
    QString lPath(SRCDIR); //aus common.cmake !
    QString lSORSPATH(SORSDIR);

    auto lTessShader = ShaderManager::getShader(QList<QString>({lPath + QString("shader/tessVertShader.vert"),
                                                                lPath + QString("shader/basicRed.frag"),
                                                                QString(),
                                                                lPath + QString("shader/tessTCS.tcs"),
                                                                lPath + QString("shader/tessTES.tes")}));
    auto lTessPlane = addRenderable<GeometryBase, TessPlane>(TessPlane(5.0f, 10.0f), lTessShader);

    auto lFilled = std::make_shared<OpenGLStates>();
    lFilled->setFilled(false);
    ECS.get<Renderable>(lTessPlane).addProperty(lFilled);

    auto lKeyTrans = addController<KeyboardTransformationController>(lTessPlane);
    lKeyTrans->setTransKeysUpper('j', 'k', 'l');
    lKeyTrans->setRotKeysUpper('u', 'i', 'o');

}
