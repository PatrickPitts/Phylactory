package org.nerdcore.spellbookmanager;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import org.apache.commons.io.FilenameUtils;

@Controller
public class FileUploadController {

    //destination folder to upload the uploads
    //TODO: Restructure file upload destination
    private static String UPLOAD_FOLDER = System.getProperty("user.dir")+"\\src\\main\\resources\\uploads\\";


    @RequestMapping("/upload")
    public ModelAndView showUpload() {
        return new ModelAndView("uploadForm");
    }

    @PostMapping("/upload")
    public ModelAndView fileUpload(@RequestParam("file") MultipartFile file, RedirectAttributes redirectAttributes) {

        if (file.isEmpty()) {
            return new ModelAndView("status", "message", "Please select a file and try again");
        }

        try {
            //FilenameUtils.getExtension(file.getOriginalFilename());
            // read and write the file to the selected location-
            byte[] bytes = file.getBytes();
            Path path = Paths.get(UPLOAD_FOLDER + file.getOriginalFilename());
            //System.out.println(UPLOAD_FOLDER + file.getOriginalFilename());
            Files.write(path, bytes);

        } catch (IOException e) {
            e.printStackTrace();
        }

        return new ModelAndView("status", "message", "File Uploaded sucessfully");
    }

}
