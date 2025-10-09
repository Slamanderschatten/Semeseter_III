#include "geometry/simpleplane.hpp"
#include "manager.hpp"
#include "ecs.hpp"
#include "rendering/openglstates.hpp"
#include "shadermanager.hpp"
#include "rendering/texture.hpp"
#include "rendering/renderable.hpp"
#include "transformation/keyboardtransformationcontroller.hpp"
#include "rendering/rendercontext.hpp"
#include "transformation/trackball.hpp"

class SimplePlaneRepeat : public SimplePlane
{
    using SimplePlane::SimplePlane;

    void fillTexCoords(QVector<QVector2D>& texCoords)
    {
        for (unsigned int y = 0; y < mDivs; y++)
        {
            for (unsigned int x = 0; x <= mDivs; x++)
            {
                texCoords.append(mXRepeats * QVector2D(x / (float)mDivs, mYRepeats * (y + 1) / (float)mDivs));
                texCoords.append(mXRepeats * QVector2D(x / (float)mDivs, mYRepeats *y / (float)mDivs));
            }
        }
    }
private:
    unsigned int mXRepeats{2};
    unsigned int mYRepeats{10};
};

void Manager::initialize()
{
    QString lPath(SRCDIR); //aus common.cmake !
    QString lSORSPATH(SORSDIR);
    QString lTOL_MODEL_PATH(lSORSPATH + "SORSLib/thirdparty/tinyobjloader/models/");

    auto lRenderContextEnt = RenderContext::addRenderContext();
    auto lRenderContext = RenderContext::getActiveRenderContext();
    lRenderContext.getCameraController()->setMoveSpeed(1.f);
    lRenderContext.getCameraController()->setRotSpeed(1.f);

    auto lShader =
        ShaderManager::getShader(QList<QString>({lPath + QString("shader/texture.vert"), lPath + QString("shader/texture.frag")}));

    auto lEnt = addRenderable<GeometryBase, SimplePlaneRepeat>(SimplePlaneRepeat(10.0f, 100.0f), lShader);
    auto &lRenderable = ECS.get<Renderable>(lEnt);
//    auto lTexture = std::make_shared<Texture>(lPath + QString("models/masonry-wall-texture.jpg"));
    auto lTexture = std::make_shared<Texture>(lPath + QString("models/stone-wall-texture.jpg"));
    lTexture->setMinFilter(GL_LINEAR);
    lTexture->setBuildMipmaps(false);
    lTexture->setMinFilter(GL_LINEAR_MIPMAP_LINEAR);
    lTexture->setBuildMipmaps(true);
    lTexture->setAnisotropyLevel(16);
    lRenderable.addProperty(lTexture);

    auto lTrackball = addController<Trackball>(lEnt);
}
