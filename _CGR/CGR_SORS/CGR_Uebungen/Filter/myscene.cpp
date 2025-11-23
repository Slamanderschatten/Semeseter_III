#include "manager.hpp"
#include "geometry/simpleplane.hpp"
#include "shadermanager.hpp"
#include "rendering/texture.hpp"
#include "rendering/timeruniform.hpp"
#include "filterMatrix.hpp"

void Manager::initialize()
{
    QString lPath = SRCDIR;
    auto lShader = ShaderManager::getShader(
        QList<QString>({lPath + QString("shader_vorlagen/texture.vert"), lPath + QString("blurred.frag")}));
    auto lEnt1 = addRenderable<GeometryBase, SimplePlane>(SimplePlane(3.0f), lShader);

    auto lTexture = std::make_shared<Texture>(lPath + QString("data/logo.bmp"));
    //Einkommentieren, um Bild aus dem Übungsblatt zu bekommen
    //lTexture->makeStripes(256, 10);
    ECS.get<Renderable>(lEnt1).addProperty(lTexture);
    float filterBlurred[9] = {
            1,2,1,
            2,4,2,
            1,2,1
    };
    float filterX[9] = {
            0,1,0,
            1,-4,1,
            0,1,0
    };
    ECS.get<Renderable>(lEnt1).addProperty(std::make_shared<FilterMatrix>(QMatrix3x3(filterX)));
}
