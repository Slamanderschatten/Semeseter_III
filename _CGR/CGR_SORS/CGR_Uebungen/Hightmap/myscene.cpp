#include "manager.hpp"
#include "ecs.hpp"
#include "shadermanager.hpp"
#include "transformation/keyboardtransformationcontroller.hpp"
#include "geometry/simpleplane.hpp"
#include <windows.h>
#include <QCoreApplication>

class Heightmap: public SimplePlane
{
public:
    Heightmap();
protected:
    virtual void fillVertices(QVector<QVector4D>& vertices) override;
    virtual void fillColors(QVector<QVector4D>& colors) override;
    QImage image;
};


Heightmap::Heightmap(): SimplePlane(1.0f) {
    image.load("motorrad.png");
    image = image.convertToFormat(QImage::Format_RGB32);
}


void Heightmap::fillVertices(QVector<QVector4D>& vertices) {
    vertices.clear();

    for (unsigned int y = 0; y < mDivs; y++)
    {
        for (unsigned int x = 0; x <= mDivs; x++)
        {
            vertices.append(QVector4D(x / (float)mDivs * mXSize, (y + 1) / (float)mDivs * mYSize, image.pixelColor(x,y).valueF(), 1.0f));
            vertices.append(QVector4D(x / (float)mDivs * mXSize, y / (float)mDivs * mYSize, 1.0f, 1.0f));
        }
    }
}

void Heightmap::fillColors(QVector<QVector4D>& colors)
{
    colors.clear();
    for (unsigned int y = 0; y < mDivs; y++)
    {
        for (unsigned int x = 0; x <= mDivs; x++)
        {
            colors.append(QVector4D(x / (float)mDivs * mXSize, (y + 1) / (float)mDivs * mYSize, 1.0f, 1.0f));
            colors.append(QVector4D(x / (float)mDivs * mXSize, y / (float)mDivs * mYSize, 1.0f, 1.0f));
        }
    }
}

void Manager::initialize()
{
    QString lPath(SRCDIR); //aus common.cmake !
    QString lSORSPATH(SORSDIR);

    auto lColoredPlane = addRenderable<GeometryBase, Heightmap>(Heightmap());

    auto lKeyTrans = addController<KeyboardTransformationController>(lColoredPlane);
    lKeyTrans->setTransKeysUpper('j', 'k', 'l');
    lKeyTrans->setRotKeysUpper('u', 'i', 'o');

}
