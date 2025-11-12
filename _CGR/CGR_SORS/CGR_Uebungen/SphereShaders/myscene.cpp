#include "manager.hpp"
#include "geometry/simpleplane.hpp"
#include "shadermanager.hpp"
#include "rendering/timeruniform.hpp"
#include "geometry/simplecube.hpp"
#include "time.hpp"

void Manager::initialize()
{
    QString lPath = SRCDIR;
    auto lShaderRotate = ShaderManager::getShader(
        QList<QString>({lPath + QString("shader/rotate.vert"), lPath + QString("shader/sphereGrid.frag")}));
    auto lEnt1 = addRenderable<GeometryBase, SimpleCube>(SimpleCube(3.0f, 3.0f, 3), lShaderRotate);
    ECS.get<Transformation>(lEnt1).translate(1.0f, 1.0f,1.0f);
    ECS.get<Renderable>(lEnt1).addProperty(std::make_shared<Time>());
}
