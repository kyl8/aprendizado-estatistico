import React from 'react';
import {Composition,registerRoot} from 'remotion';
import {Deck} from './Deck';
import {slides,FPS,FRAMES_PER_SLIDE} from './slides';
function Root(){return <Composition id="APPA" component={Deck} durationInFrames={slides.length*FRAMES_PER_SLIDE} width={1600} height={900} fps={FPS} defaultProps={{interactive:false}}/>;}
registerRoot(Root);
