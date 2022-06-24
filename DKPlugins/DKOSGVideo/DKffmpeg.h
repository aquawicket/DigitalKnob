#pragma once
#ifndef DKffmpeg_H
#define DKffmpeg_H

#include <osgViewer/Viewer>
#include <osgViewer/ViewerEventHandlers>
#include <osgDB/ReadFile>
#include <osg/Geode>
#include <osg/Geometry>
#include <osg/StateSet>
#include <osg/Material>
#include <osg/Texture2D>
#include <osg/TextureRectangle>
#include <osg/TextureCubeMap>
#include <osg/TexMat>
#include <osg/CullFace>
#include <osg/ImageStream>
#include <osg/io_utils>
#include <osgGA/TrackballManipulator>
#include <osgGA/StateSetManipulator>
#include <osgGA/EventVisitor>
#include <iostream>

class MovieEventHandler : public osgGA::GUIEventHandler
{
public:
    MovieEventHandler():_trackMouse(false) {}
    void setMouseTracking(bool track) { _trackMouse = track; }
    bool getMouseTracking() const { return _trackMouse; }
    void set(osg::Node* node);
    virtual bool handle(const osgGA::GUIEventAdapter& ea,osgGA::GUIActionAdapter& aa, osg::Object*, osg::NodeVisitor* nv);
    virtual void getUsage(osg::ApplicationUsage& usage) const;
    typedef std::vector< osg::observer_ptr<osg::ImageStream> > ImageStreamList;
protected:
    virtual ~MovieEventHandler(){}
    class FindImageStreamsVisitor : public osg::NodeVisitor
	{
    public:
        FindImageStreamsVisitor(ImageStreamList& imageStreamList): _imageStreamList(imageStreamList) {
        virtual void apply(osg::Geode& geode){
            apply(geode.getStateSet());
            for(unsigned int i=0;i<geode.getNumDrawables();++i)
                apply(geode.getDrawable(i)->getStateSet());
            traverse(geode);
        }
        virtual void apply(osg::Node& node){
            apply(node.getStateSet());
            traverse(node);
        }
        inline void apply(osg::StateSet* stateset){
            if (!stateset) 
				return;
            osg::StateAttribute* attr = stateset->getTextureAttribute(0,osg::StateAttribute::TEXTURE);
            if (attr){
                osg::Texture2D* texture2D = dynamic_cast<osg::Texture2D*>(attr);
                if (texture2D) 
					apply(dynamic_cast<osg::ImageStream*>(texture2D->getImage()));
                osg::TextureRectangle* textureRec = dynamic_cast<osg::TextureRectangle*>(attr);
                if (textureRec) 
					apply(dynamic_cast<osg::ImageStream*>(textureRec->getImage()));
            }
        }
        inline void apply(osg::ImageStream* imagestream){
            if (imagestream)
                _imageStreamList.push_back(imagestream);
        }
        ImageStreamList& _imageStreamList;
    protected:
        FindImageStreamsVisitor& operator = (const FindImageStreamsVisitor&) { return *this; }

    };
    bool            _trackMouse;
    ImageStreamList _imageStreamList;
    unsigned int    _seekIncr;
};


#if USE_SDL
class SDLAudioSink : public osg::AudioSink
{
    public:
        SDLAudioSink(osg::AudioStream* audioStream): _started(false), _paused(false), _audioStream(audioStream){}
        ~SDLAudioSink();
        virtual void play();
        virtual void pause();
        virtual void stop();
        virtual bool playing() const { return _started && !_paused; }
        bool _started;
        bool _paused;
        osg::observer_ptr<osg::AudioStream> _audioStream;
};
#endif

static osg::Geometry* myCreateTexturedQuadGeometry(const osg::Vec3& pos,float width,float height, osg::Image* image, bool useTextureRectangle, bool xyPlane, bool option_flip){
    bool flip = image->getOrigin()==osg::Image::TOP_LEFT;
	if (option_flip)
		flip = !flip;
    if (useTextureRectangle){
        osg::Geometry* pictureQuad = osg::createTexturedQuadGeometry(pos,
                                           osg::Vec3(width,0.0f,0.0f),
                                           xyPlane ? osg::Vec3(0.0f,height,0.0f) : osg::Vec3(0.0f,0.0f,height),
                                           0.0f, flip ? image->t() : 0.0, image->s(), flip ? 0.0 : image->t());
        osg::TextureRectangle* texture = new osg::TextureRectangle(image);
        texture->setWrap(osg::Texture::WRAP_S, osg::Texture::CLAMP_TO_EDGE);
        texture->setWrap(osg::Texture::WRAP_T, osg::Texture::CLAMP_TO_EDGE);
        pictureQuad->getOrCreateStateSet()->setTextureAttributeAndModes(0, texture, osg::StateAttribute::ON);
        return pictureQuad;
    }
    else{
        osg::Geometry* pictureQuad = osg::createTexturedQuadGeometry(pos,
                                           osg::Vec3(width,0.0f,0.0f),
                                           xyPlane ? osg::Vec3(0.0f,height,0.0f) : osg::Vec3(0.0f,0.0f,height),
                                           0.0f, flip ? 1.0f : 0.0f , 1.0f, flip ? 0.0f : 1.0f);
        osg::Texture2D* texture = new osg::Texture2D(image);
        texture->setResizeNonPowerOfTwoHint(false);
        texture->setFilter(osg::Texture::MIN_FILTER,osg::Texture::LINEAR);
        texture->setWrap(osg::Texture::WRAP_S, osg::Texture::CLAMP_TO_EDGE);
        texture->setWrap(osg::Texture::WRAP_T, osg::Texture::CLAMP_TO_EDGE);
        pictureQuad->getOrCreateStateSet()->setTextureAttributeAndModes(0, texture, osg::StateAttribute::ON);
        return pictureQuad;
    }
}

#endif //DKffmpeg_H



///  osgmovie.cpp main() ///
/*
int main(int argc, char** argv)
{
	osgDB::setDataFilePathList(datapaths);
    // use an ArgumentParser object to manage the program arguments.
    osg::ArgumentParser arguments(&argc,argv);
    // set up the usage document, in case we need to print out how to use this program.
    arguments.getApplicationUsage()->setApplicationName(arguments.getApplicationName());
    arguments.getApplicationUsage()->setDescription(arguments.getApplicationName()+" example demonstrates the use of ImageStream for rendering movies as textures.");
    arguments.getApplicationUsage()->setCommandLineUsage(arguments.getApplicationName()+" [options] filename ...");
    arguments.getApplicationUsage()->addCommandLineOption("-h or --help","Display this information");
    arguments.getApplicationUsage()->addCommandLineOption("--texture2D","Use Texture2D rather than TextureRectangle.");
    arguments.getApplicationUsage()->addCommandLineOption("--shader","Use shaders to post process the video.");
    arguments.getApplicationUsage()->addCommandLineOption("--interactive","Use camera manipulator to allow movement around movie.");
    arguments.getApplicationUsage()->addCommandLineOption("--flip","Flip the movie so top becomes bottom.");
#if defined(WIN32) || defined(__APPLE__)
    arguments.getApplicationUsage()->addCommandLineOption("--devices","Print the Video input capability via QuickTime and exit.");
#endif
    bool useTextureRectangle = true;
    bool useShader = false;
    // construct the viewer.
    osgViewer::Viewer viewer(arguments);
    if (arguments.argc()<=1){
        arguments.getApplicationUsage()->write(std::cout,osg::ApplicationUsage::COMMAND_LINE_OPTION);
        return 1;
    }
#if defined(WIN32) || defined(__APPLE__)
    // if user requests devices video capability.
    if (arguments.read("-devices") || arguments.read("--devices")) {
        // Force load QuickTime plugin, probe video capability, exit
        osgDB::readImageFile("devices.live");
        return 1;
    }
#endif
    while (arguments.read("--texture2D")) useTextureRectangle=false;
    while (arguments.read("--shader")) useShader=true;
    bool mouseTracking = false;
    while (arguments.read("--mouse")) mouseTracking=true;
    // if user request help write it out to cout.
    if (arguments.read("-h") || arguments.read("--help")){
        arguments.getApplicationUsage()->write(std::cout);
        return 1;
    }
    bool fullscreen = !arguments.read("--interactive");
    bool flip = arguments.read("--flip");
    osg::ref_ptr<osg::Geode> geode = new osg::Geode;
    osg::StateSet* stateset = geode->getOrCreateStateSet();
    stateset->setMode(GL_LIGHTING,osg::StateAttribute::OFF);
    if (useShader){
        //useTextureRectangle = false;
        static const char *shaderSourceTextureRec = {
            "uniform vec4 cutoff_color;\n"
            "uniform samplerRect movie_texture;\n"
            "void main(void)\n"
            "{\n"
            "    vec4 texture_color = textureRect(movie_texture, gl_TexCoord[0].st); \n"
            "    if (all(lessThanEqual(texture_color,cutoff_color))) discard; \n"
            "    gl_FragColor = texture_color;\n"
            "}\n"
        };
        static const char *shaderSourceTexture2D = {
            "uniform vec4 cutoff_color;\n"
            "uniform sampler2D movie_texture;\n"
            "void main(void)\n"
            "{\n"
            "    vec4 texture_color = texture2D(movie_texture, gl_TexCoord[0].st); \n"
            "    if (all(lessThanEqual(texture_color,cutoff_color))) discard; \n"
            "    gl_FragColor = texture_color;\n"
            "}\n"
        };
        osg::Program* program = new osg::Program;
        program->addShader(new osg::Shader(osg::Shader::FRAGMENT,useTextureRectangle ? shaderSourceTextureRec : shaderSourceTexture2D));
        stateset->addUniform(new osg::Uniform("cutoff_color",osg::Vec4(0.1f,0.1f,0.1f,1.0f)));
        stateset->addUniform(new osg::Uniform("movie_texture",0));
        stateset->setAttribute(program);
    }
    osg::Vec3 pos(0.0f,0.0f,0.0f);
    osg::Vec3 topleft = pos;
    osg::Vec3 bottomright = pos;
    bool xyPlane = fullscreen;
    bool useAudioSink = false;
    while(arguments.read("--audio")) { useAudioSink = true; }
#if USE_SDL
    unsigned int numAudioStreamsEnabled = 0;
#endif
    for(int i=1;i<arguments.argc();++i){
        if (arguments.isString(i)){
            osg::Image* image = osgDB::readImageFile(arguments[i]);
            osg::ImageStream* imagestream = dynamic_cast<osg::ImageStream*>(image);
            if (imagestream){
                osg::ImageStream::AudioStreams& audioStreams = imagestream->getAudioStreams();
                if (useAudioSink && !audioStreams.empty()){
                    osg::AudioStream* audioStream = audioStreams[0].get();
                    osg::notify(osg::NOTICE)<<"AudioStream read ["<<audioStream->getName()<<"]"<<std::endl;
#if USE_SDL
                    if (numAudioStreamsEnabled==0){
                        audioStream->setAudioSink(new SDLAudioSink(audioStream));   
                        ++numAudioStreamsEnabled;
                    }
#endif
                }
                imagestream->play();
            }
            if(image){
                osg::notify(osg::NOTICE)<<"image->s()"<<image->s()<<" image-t()="<<image->t()<<" aspectRatio="<<image->getPixelAspectRatio()<<std::endl;
                float width = image->s() * image->getPixelAspectRatio();
                float height = image->t();
                osg::ref_ptr<osg::Drawable> drawable = myCreateTexturedQuadGeometry(pos, width, height,image, useTextureRectangle, xyPlane, flip);
                
                if (image->isImageTranslucent()){
                    osg::notify(osg::NOTICE)<<"Transparent movie, enabling blending."<<std::endl;
                    drawable->getOrCreateStateSet()->setMode(GL_BLEND, osg::StateAttribute::ON);
                    drawable->getOrCreateStateSet()->setRenderingHint(osg::StateSet::TRANSPARENT_BIN);
                }
                geode->addDrawable(drawable.get());
                bottomright = pos + osg::Vec3(width,height,0.0f);

                if (xyPlane) pos.y(){ += height*1.05f; }
                else pos.z(){ += height*1.05f; }
            }
            else{
                std::cout<<"Unable to read file "<<arguments[i]<<std::endl;
            }
        }
    }
    // set the scene to render
    viewer.setSceneData(geode.get());
    if (viewer.getSceneData()==0){
        arguments.getApplicationUsage()->write(std::cout);
        return 1;
    }
    // pass the model to the MovieEventHandler so it can pick out ImageStream's to manipulate.
    MovieEventHandler* meh = new MovieEventHandler();
    meh->setMouseTracking( mouseTracking );
    meh->set( viewer.getSceneData() );
    viewer.addEventHandler( meh );
    viewer.addEventHandler( new osgViewer::StatsHandler );
    viewer.addEventHandler( new osgGA::StateSetManipulator( viewer.getCamera()->getOrCreateStateSet() ) );
    viewer.addEventHandler( new osgViewer::WindowSizeHandler );
    // add the record camera path handler
    viewer.addEventHandler(new osgViewer::RecordCameraPathHandler);
    // report any errors if they have occurred when parsing the program arguments.
    if(arguments.errors()){
        arguments.writeErrorMessages(std::cout);
        return 1;
    }
    if (fullscreen){
        viewer.realize();   
        viewer.getCamera()->setClearColor(osg::Vec4(0.0f,0.0f,0.0f,1.0f));
        float screenAspectRatio = 1280.0f/1024.0f;
        osg::GraphicsContext::WindowingSystemInterface* wsi = osg::GraphicsContext::getWindowingSystemInterface();
        if (wsi) {
            unsigned int width, height;
            wsi->getScreenResolution(osg::GraphicsContext::ScreenIdentifier(0), width, height);
            screenAspectRatio = float(width) / float(height);
        }
        float modelAspectRatio = (bottomright.x()-topleft.x())/(bottomright.y()-topleft.y()); 
        viewer.getCamera()->setViewMatrix(osg::Matrix::identity());
        osg::Vec3 center = (bottomright + topleft)*0.5f;
        osg::Vec3 dx(bottomright.x()-center.x(), 0.0f, 0.0f);
        osg::Vec3 dy(0.0f, topleft.y()-center.y(), 0.0f);
        float ratio = modelAspectRatio/screenAspectRatio;
        if (ratio>1.0f){
            // use model width as the control on model size.
            bottomright = center + dx - dy * ratio;
            topleft = center - dx + dy * ratio;
        }
        else{
            // use model height as the control on model size.
            bottomright = center + dx / ratio - dy;
            topleft = center - dx / ratio + dy;
        }
        viewer.getCamera()->setProjectionMatrixAsOrtho2D(topleft.x(),bottomright.x(),topleft.y(),bottomright.y());
        while(!viewer.done())
            viewer.frame();
        return 0;
    }
    else{
        // create the windows and run the threads.
        return viewer.run();
    }
}
*/
