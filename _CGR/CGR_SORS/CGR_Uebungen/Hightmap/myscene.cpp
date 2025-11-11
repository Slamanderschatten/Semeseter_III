#include "manager.hpp"
#include "ecs.hpp"
#include "shadermanager.hpp"
#include "transformation/keyboardtransformationcontroller.hpp"
#include "geometry/simpleplane.hpp"
#include <windows.h>
#include <QCoreApplication>

class Heightmap: public IGeometryImplementation
{
public:
    Heightmap();
protected:
    virtual void fillVertices(QVector<QVector4D>& vertices) override;
    virtual void fillColors(QVector<QVector4D>& colors) override;
    void render() override;
    QImage image;
    QVector<QVector4D> colorBuffer; // Speichert Farbwerte für fillColors()
};


Heightmap::Heightmap(): IGeometryImplementation() {
    QString lPath(SRCDIR); //aus common.cmake !
    image.load(lPath+"motorrad.png");
    image = image.convertToFormat(QImage::Format_RGB32);
}


void Heightmap::fillVertices(QVector<QVector4D>& vertices) {
    vertices.clear();

    int width = image.width();
    int height = image.height();

    // Normierung, damit die Punkte in einem definierten Bereich liegen
    float xScale = 1.0f / width * 15;
    float yScale = 1.0f / height * 15;

    for (int y = 0; y < height; ++y) {
        for (int x = 0; x < width; ++x) {
            QColor color = image.pixelColor(x, y);

            // Helligkeit berechnen (0.0 - 1.0)
            float brightness = color.redF() * 0.299f + color.greenF() * 0.587f + color.blueF() * 0.114f;

            // Vertex-Position: z = Helligkeit
            QVector4D vertex(x * xScale, y * yScale, brightness*15, 1.0f);
            vertices.append(vertex);

            // Farbe des Pixels speichern
            colorBuffer.append(QVector4D(color.redF(), color.greenF(), color.blueF(), 1.0f));
        }
    }
}

void Heightmap::fillColors(QVector<QVector4D>& colors)
{
    colors = colorBuffer;
}


void Heightmap::render() {


    for (unsigned int y = 0; y < image.height(); y++)
    {
        glFunctions->glDrawArrays(GL_POINTS, y * (2 * image.height() + 2), 2 * image.width() + 2);
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
