#ifndef TESSPLANE_HPP
#define TESSPLANE_HPP

#include <QVector4D>
#include <QList>
#include "input/inputregistry.hpp"
#include "simpleplane.hpp"
#include "rendering/rendercontext.hpp"

class TessPlane: public SimplePlane
{
public:
    TessPlane(float pSizeX, float pSizeY): SimplePlane(pSizeX, pSizeY, 1) {}
protected:
    void keyboard()
    {
        auto keyIn = InputRegistry::getInstance().getKeyboardInput();

        if (keyIn->isKeyPressed('1'))
            mInnerLevels--;
        else if (keyIn->isKeyPressed('2'))
            mInnerLevels++;
        else if (keyIn->isKeyPressed('3'))
            mOuterLevels--;
        else if (keyIn->isKeyPressed('4'))
            mOuterLevels++;
    }
    void fillVertices(QVector<QVector4D>& vertices) override
    {
        float width = mXSize;
        float height = mYSize;
        vertices.clear();
        // Tri one
        vertices.append(QVector4D(-0.5f * width, -0.5f * height, 0.f, 1.0f));
        vertices.append(QVector4D(0.5f * width, -0.5f * height, 0.f, 1.0f));
        vertices.append(QVector4D(-0.5f * width, 0.5f * height, 0.f, 1.0f));
        vertices.append(QVector4D(-0.5f * width, 0.5f * height, 0.f, 1.0f));
        vertices.append(QVector4D(0.5f * width, -0.5f * height, 0.f, 1.0f));
        vertices.append(QVector4D(0.5f * width, 0.5f * height, 0.f, 1.0f));
    }

    void fillTexCoords(QVector<QVector2D>& texCoords) override
    {
        texCoords.clear();
        texCoords.append(QVector2D(0.0, 0.0));
        texCoords.append(QVector2D(1.0, 0.0));
        texCoords.append(QVector2D(0.0, 1.0));
        texCoords.append(QVector2D(0.0, 1.0));
        texCoords.append(QVector2D(1.0, 0.0));
        texCoords.append(QVector2D(1.0, 1.0));
    }

    virtual void render() override
    {
        keyboard();
        auto lShaderProgram = RenderContext::getActiveRenderContext().getActiveShader();
        lShaderProgram.shaderProgram()->setPatchVertexCount(3);
        lShaderProgram.shaderProgram()->setUniformValue("TessLevelOuter", mOuterLevels);
        lShaderProgram.shaderProgram()->setUniformValue("TessLevelInner", mInnerLevels);

        glFunctions->glDrawArrays(GL_PATCHES, 0, 6);
    }
    float mInnerLevels{1.0f};
    float mOuterLevels{1.0f};
};

#endif // TESSPLANE_HPP
