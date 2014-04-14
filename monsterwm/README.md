    git clone git://github.com/c00kiemon5ter/monsterwm.git

    git checkout xinerama-init
    git cherry-pick origin/uselessgaps
    git cherry-pick origin/rectangle

    make clean && make

    # edit config.h as needed, or use my config, or whatever

    make clean && make

    # copy ./monsterwm to wherever
